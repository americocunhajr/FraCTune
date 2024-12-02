% -----------------------------------------------------------------
%  MainCEoptCase1_FOSMC.m
% -----------------------------------------------------------------
%  programmer: Julio Cesar de Castro Basilio
%              basilio.julio@posgraduacao.uerj.br
%
%  Originally programmed in: Nov 30, 2024
%           Last updated in: Nov 30, 2024
% -----------------------------------------------------------------
%  ﻿﻿Case 1: Inverted Pendulum with Fractional-order Sliding Mode Control
%  (this case may take several minutes to run)
%  Optimizer: Cross-Entropy Method
% -----------------------------------------------------------------

clc; clear; close all;

disp(' -------------------------- ')
disp(' MainCEoptCase1_FOSMC.m ')
disp(' -------------------------- ')
disp('Case 1: Inverted Pendulum with Fractional-order Sliding Mode Control')
disp('(this case may take several minutes to run)')
disp(' Optimizer: Cross-Entropy Method')


% random number generator (fix the seed for reproducibility)
 rng_stream = RandStream('mt19937ar','Seed',30081984);
 RandStream.setGlobalStream(rng_stream);

% system parameters
global k lambda1 lambda2 lambda3 OrderD
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

% lower and upper bounds for design variables
lb = [0    ;-100   ;-100 ;-100 ; 0.001];
ub = [100  ; 0     ; 0   ; 0   ; 0.900];

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
[Xopt,Fopt,ExitFlag,CEobj] = CEopt(fun,xmean0,[],lb,ub,nonlcon,CEobj);
elapsedTime = toc;

save Results_CE_FOSMC

% objective functcion
function F = MyObjFunc(x)
    global k lambda1 lambda2 lambda3 OrderD
    k=x(1);
    lambda1=x(2);
    lambda2=x(3);
    lambda3=x(4);
    OrderD=x(5);
    
    sim('FOSMCControllerCartPendulum.slx');
     
    F = trapz(tout,(e).^2);
end

% inequality constraints
function [G,H] = MyConstFunc(x)
    global k lambda1 lambda2 lambda3 OrderD
    k=x(1);
    lambda1=x(2);
    lambda2=x(3);
    lambda3=x(4);
    OrderD=x(5);

    sim('FOSMCControllerCartPendulum.slx');
    
    G = max(abs(xdisp)) - 2.5;
    H = [];
end