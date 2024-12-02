% -----------------------------------------------------------------
%  MainGAoptCase3_PID.m
% -----------------------------------------------------------------
%  programmer: Julio Cesar de Castro Basilio
%              basilio.julio@posgraduacao.uerj.br
%
%  Originally programmed in: Nov 30, 2024
%           Last updated in: Nov 30, 2024
% -----------------------------------------------------------------
%  ﻿﻿Case 3: Active Suspension with Classical
%  ﻿﻿Proportional-Integrative-Derivative Control
%  (this example may take several minutes to run)
%  Optimizer: Genetic Algorithm Method
% -----------------------------------------------------------------

clc; clear; close all;

disp(' -------------------------- ')
disp(' MainGAoptCase3_PID.m ')
disp(' -------------------------- ')
disp('﻿﻿Case 3: Active Suspension with Classical')
disp('﻿﻿Proportional-Integrative-Derivative Control')
disp('(this case may take several minutes to run)')
disp(' Optimizer: Genetic Algorithm Method')

% random number generator (fix the seed for reproducibility)
 rng_stream = RandStream('mt19937ar','Seed',30081984);
 RandStream.setGlobalStream(rng_stream);

% system parameters
global Kp Ki Kd 
mu = 40;
ms = 250;
ku = 200000;
ks = 10000;
bs = 650;
r  = 0;
OrderI = 1;
OrderD = 1;

% Road profile (m)
load('h.mat','h','desl');
% Travel speed (m/s)
v = 15;
% Observed travel time (s)
t = desl/v;
h = h';

% objective and constraint functions
fun     = @(x) MyObjFunc(x);
nonlcon = @(x) MyConstFunc(x);

Nvars=3;

% lower and upper bounds for design variables
lb = [-1000;-1000 ;-1000];
ub = [ 1000; 1000 ; 1000];

% initialize mean and std. dev. vectors
xmean0     = [-500;-500; 600];
sigma0 = (ub-lb)/sqrt(12);

% GA optimizer struct
GAobj.EliteFactor  = 0.05;    % Elite samples percentage
GAobj.Nsamp        = 100;     % Number of samples
GAobj.MaxIter      = 15;      % Maximum number of iterations
GAobj.TolCon       = 1.0e-2;  % Constraint tolerance
GAobj.TolFun       = 1.0e-3;  % Function tolerance

% GA solver
tic
options = optimoptions(@ga, 'Display','iter',...
                            'PopulationSize',GAobj.Nsamp,...
                            'EliteCount', ceil(GAobj.EliteFactor*GAobj.Nsamp),...
                            'InitialPopulationMatrix',xmean0',...
                            'Generations', GAobj.MaxIter,...
                            'TolFun', GAobj.TolFun,...
                            'TolCon', GAobj.TolCon,...
                            'OutputFcns',@ga_save_each_gen);
 
[Xopt,Fopt,exitflag,output,population,scores] = ga(fun,Nvars,[],[],[],[],lb,ub,nonlcon,options);
elapsedTime = toc;

save Results_GA_PID

% objective functcion
function F = MyObjFunc(x)
    global Kp Ki Kd 
    Kp = x(1);
    Ki = x(2);
    Kd = x(3);
    
    sim('ControllerSuspActive.slx');
     
  F = rms(Am2(1/10*end:end)) ...
  + trapz(tout(1/10*end:end),Zs(1/10*end:end).^2);
 end

% inequality constraints
function [G,H] = MyConstFunc(x)
    global Kp Ki Kd 
    Kp = x(1);
    Ki = x(2);
    Kd = x(3);
    
R=0.75;
ms=250;
UC=0.127;

    sim('ControllerSuspActive.slx');

    G = zeros(2,1);
    G(1) = abs(min(Fdin(1/10*end:end))) - ((1-R)*ms*9.81);
    G(2) = max(abs(Ds)) - UC/2;
    G = G';
    H = [];
end