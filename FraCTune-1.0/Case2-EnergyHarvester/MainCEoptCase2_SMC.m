% -----------------------------------------------------------------
%  MainCEoptCase2_SMC.m
% -----------------------------------------------------------------
%  programmer: Julio Cesar de Castro Basilio
%              basilio.julio@posgraduacao.uerj.br
%
%  Originally programmed in: Nov 30, 2024
%           Last updated in: Nov 30, 2024
% -----------------------------------------------------------------
%  ﻿﻿Case 2: Bistable Energy Harvesting with Sliding Mode Control
%  (this case may take several minutes to run)
%  Optimizer: Cross-Entropy Method
% -----------------------------------------------------------------

clc; clear; close all;

disp(' -------------------------- ')
disp(' MainGAoptExample2_SMC.m ')
disp(' -------------------------- ')
disp('Case 2: Bistable Energy Harvesting with Sliding Mode Control')
disp('(this case may take several minutes to run)')
disp(' Optimizer: Cross-Entropy Method')

% random number generator (fix the seed for reproducibility)
 rng_stream = RandStream('mt19937ar','Seed',30081984);
 RandStream.setGlobalStream(rng_stream);

% system parameters
global k lambda1 time lambda
ksi        = 0.01;  
chi        = 0.05;  
lambda     = 0.05;  
kappa      = 0.5;   
fa         = 0.2;
Omega      = 0.8;
phi        = 0.59;
f_ref      = 0.2;
Omega_ref  = 0.8;
xdisp0     = 1.0;
dxdisp0    = 0.0;

% Time / Samples
t0 = 0.0;
sampleTime=0.1;
t1 = 100;
tspan = t0:sampleTime:t1;
time = tspan';
simulationTime=t1;

% objective and constraint functions
fun     = @(x) MyObjFunc(x);
nonlcon = @(x) MyConstFunc(x);

% lower and upper bounds for design variables
lb = [0 ;  0];
ub = [20; 20];

% initialize mean and std. dev. vectors
xmean0     = (ub+lb)/2;
sigma0 = (ub-lb)/sqrt(12);

% cross-entropy optimizer struct
CEobj.EliteFactor  = 0.05;    % Elite samples percentage
CEobj.Nsamp        = 100;     % Number of samples
CEobj.TolCon       = 1.0e-2;  % Constraint tolerance
CEobj.TolRel       = 1.0e-2;  % Relative tolerance

% CE solver
tic
[Xopt,Fopt,ExitFlag,CEobj] = CEopt(fun,xmean0,sigma0,lb,ub,nonlcon,CEobj);
elapsedTime = toc;

save Results_CE_SMC

% objective functcion
function F = MyObjFunc(x)
    global k lambda1 time lambda
    k=x(1);
    lambda1=x(2);
    
    sim('SMCControllerEH.slx');
     
% time interval of analysis
T = time(end)-time(1);
% output power
power = lambda.*(v.^2);
% mean output power
power_mean = (1/T).*trapz(time,power);

F = 1/power_mean;
end

% inequality constraints
function [G,H] = MyConstFunc(x)
    global k lambda1
    k=x(1);
    lambda1=x(2);

    sim('SMCControllerEH.slx');
    
    G = max(abs(u)) - 5;
    H = [];
end