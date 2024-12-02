% -----------------------------------------------------------------
%  MainCEoptCase4_PID.m
% -----------------------------------------------------------------
%  programmer: Julio Cesar de Castro Basilio
%              basilio.julio@posgraduacao.uerj.br
%
%  Originally programmed in: Nov 30, 2024
%           Last updated in: Nov 30, 2024
% -----------------------------------------------------------------
%  ﻿﻿Case 4: SIRDQ with Classical
%  ﻿﻿Proportional-Integrative-Derivative Control
%  (this example may take several minutes to run)
%  Optimizer: Cross Entropy Method
% -----------------------------------------------------------------

clc; clear; close all;

disp(' -------------------------- ')
disp(' MainCEoptCase4_PID.m ')
disp(' -------------------------- ')
disp('﻿﻿Case 4: SIRDQ with Classical')
disp('﻿﻿Proportional-Integrative-Derivative Control')
disp('(this case may take several minutes to run)')
disp(' Optimizer: Cross Entropy Method')

% random number generator (fix the seed for reproducibility)
 rng_stream = RandStream('mt19937ar','Seed',30081984);
 RandStream.setGlobalStream(rng_stream);

% system parameters
global Kp Ki Kd
R0_ref  = 0.5;
N       = 1000000;
theta    = 1/30;
beta1    = 1/3;
gamma1 = 0.1;
gamma2 = 0.01;
I_ini   = 4;
R_ini   = 0;
D_ini   = 0;
Q_ini   = 0;
S_ini   = N-I_ini;
C_ini   = I_ini;

% Quarantine Period
tzero  = 30;
tfinal = 60;

% time interval of analysis
t0 = 0;                % initial time (days)
t1 = 300;              % final time   (days)
dt = 1;                % time steps   (days)
tspan = t0:dt:t1;      % interval of analysis
Ndt   = length(tspan); % number of time steps

% Classical Order
OrderI=1; 
OrderD=1;

% objective and constraint functions
fun     = @(x) MyObjFunc(x);
nonlcon = @(x) MyConstFunc(x);

NVar = 3; % Number of variables

% lower and upper bounds for design variables
lb = [0.001; 0.001; 0.001];
ub = [0.3  ; 0.3  ; 0.3  ];

% initialize mean and std. dev. vectors
xmean0 = (ub+lb)/2;
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

save Results_CE_PID

% objective functcion
function F = MyObjFunc(x)
    global Kp Ki Kd
    Kp = x(1);
    Ki = x(2);
    Kd = x(3);
    
    sim('ControllerSIRDQ.slx');
     
    F = trapz(tout,(D));
end

% inequality constraints
function [G,H] = MyConstFunc(x)
    global Kp Ki Kd
    Kp = x(1);
    Ki = x(2);
    Kd = x(3);

    N = 1000000;
    sim('ControllerSIRDQ.slx');
    
    G    = zeros(2,1);
    G(1) = max(usignal(30:60)) - 1;
    G(2) = -min(usignal(30:60));
    G(3) = max(Q) - 0.6*N;
    G    = G';

    H = [];
end