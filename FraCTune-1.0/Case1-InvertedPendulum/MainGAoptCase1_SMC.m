% -----------------------------------------------------------------
%  MainGAoptCase1_SMC.m
% -----------------------------------------------------------------
%  programmer: Julio Cesar de Castro Basilio
%              basilio.julio@posgraduacao.uerj.br
%
%  Originally programmed in: Nov 30, 2024
%           Last updated in: Nov 30, 2024
% -----------------------------------------------------------------
%  ﻿﻿Case 1: Inverted Pendulum with Sliding Mode Control
%  (this case may take several minutes to run)
%  Optimizer: Genetic Algorithm Method
% -----------------------------------------------------------------

clc; clear; close all;

disp(' -------------------------- ')
disp(' MainGAoptCase1_SMC.m ')
disp(' -------------------------- ')
disp('Case 1: Inverted Pendulum with Sliding Mode Control')
disp('(this case may take several minutes to run)')
disp(' Optimizer: Genetic Algorithm Method')

% random number generator (fix the seed for reproducibility)
 rng_stream = RandStream('mt19937ar','Seed',30081984);
 RandStream.setGlobalStream(rng_stream);

% system parameters
global k lambda1
m       = 0.1;
M       = 2.0;
L       = 0.5;
J       = 0.006;
r       = 0.0;
xdisp0  = 0.0;
dxdisp0 = 0.0;
theta0  = 10*pi/180;
dtheta0 =  0.0*pi/180;

% simulation window
t_end  = 3.0;
dt     = 0.0001;

% auxiliar parameters
A = (M+m)*(J+m*L^2);
B = m*L;
C = M+m;

% objective and constraint functions
fun     = @(x) MyObjFunc(x);
nonlcon = @(x) MyConstFunc(x);

Nvars=2;

% lower and upper bounds for design variables
lb = [0  ;-100];
ub = [100; 0  ];

% initialize mean and std. dev. vectors --------------------------
xmean0     = (ub+lb)/2;
sigma0 = (ub-lb)/sqrt(12);

% GA optimizer struct
GAobj.EliteFactor  = 0.05;    % Elite samples percentage
GAobj.Nsamp        = 100;     % Number of samples
GAobj.MaxIter      = 15;      % Maximum number of iterations
GAobj.TolCon       = 1.0e-2;  % Constraint tolerance
GAobj.TolFun       = 1.0e-3;  % Function tolerance

% GA solver
tic
options = optimoptions(@ga,'Display','iter',...
                        'PopulationSize',GAobj.Nsamp,...
                        'EliteCount', ceil(GAobj.EliteFactor*GAobj.Nsamp),...
                        'InitialPopulationMatrix',xmean0',...
                        'Generations', GAobj.MaxIter,...                           
                        'TolFun', GAobj.TolFun,...
                        'TolCon', GAobj.TolCon,...
                        'OutputFcns',@ga_save_each_gen);                    

[Xopt,Fopt,exitflag,output,population,scores] = ga(fun,Nvars,[],[],[],[],lb,ub,nonlcon,options);
elapsedTime = toc;

save Results_GA_SMC

% objective functcion
function F = MyObjFunc(x)
    global k lambda1
    k=x(1);
    lambda1=x(2);
    
    sim('SMCControllerCartPendulum.slx');
     
    F = trapz(tout,e.^2);
end

% inequality constraints
function [G,H] = MyConstFunc(x)
    global k lambda1
    k=x(1);
    lambda1=x(2);

    sim('SMCControllerCartPendulum.slx');
    
    G = max(abs(xdisp)) - 2.5;
    H = [];
end