clc; clear; close all;

disp(' ------------------- ')
disp(' Basinofattraction.m ')
disp(' ------------------- ')

% system parameters
global k lambda1 lambda2 lambda3 OrderD time lambda
ksi        = 0.01;  
chi        = 0.05;  
lambda     = 0.05;  
kappa      = 0.5;   
fa         = 0.2;
Omega      = 0.8;
phi        = 0.59;
f_ref      = 0.2;
Omega_ref  = 0.8;
% xdisp0     = 1.0;
% dxdisp0    = 0.0;

% Time / Samples
t0 = 0.0;
sampleTime = 0.1;
t1 = 100;
tspan = t0:sampleTime:t1;
time = tspan';
simulationTime=t1;

% Load optimized controller parameters
 load('Results_GA_SMC.mat','Xopt')
% load('Results_CE_SMC.mat','Xopt')
% load('Results_GA_FOSMC.mat','Xopt')
% load('Results_CE_FOSMC.mat','Xopt')
k = Xopt(1);
lambda1 = Xopt(2);
lambda2 = Xopt(3);
lambda3 = Xopt(4);
OrderD  = Xopt(5);

% Initial velocity (xdisp) and position (dxdisp) of EH
% Define ranges of velocity (m/s) and position (m)  
xdisp_range = 0.8:0.01:1.2;  
dxdisp_range = -12:0.1:12;  

% Initialize arrays to store valid initial conditions
valid_xdisp0 = [];
valid_dxdisp0 = [];

% Run simulations over the grid of initial conditions
for xdisp0 = xdisp_range
    for dxdisp0 = dxdisp_range
        
% Run the simulation
             sim('SMCControllerEHc.slx');
           %  sim('FOSMCControllerEH.slx');

        % Check final value of control signal
        % time interval of analysis
        T = time(end)-time(1);
        % output power
        power = lambda.*(v.^2);
        % mean output power
        power_mean_final = (1/T)*trapz(time,power);
        u_final = max(abs(u));

        % If power_mean_final is greater than 1% power_mean_final, store the initial conditions
        if  u_final < 5 %&& power_mean_final > 0.01647*0.98
            valid_xdisp0 = [valid_xdisp0; xdisp0]; % Store xdisp0 in degrees
            valid_dxdisp0 = [valid_dxdisp0; dxdisp0];   % Store dxdisp0 in rad/s
        end
    end
end     
 
% Save the results
 save('Basin_GA_SMC.mat'  , 'valid_xdisp0', 'valid_dxdisp0');
% save('Basin_CE_SMC.mat'  , 'valid_xdisp0', 'valid_dxdisp0');
% save('Basin_GA_FOSMC.mat', 'valid_xdisp0', 'valid_dxdisp0');
% save('Basin_CE_FOSMC.mat', 'valid_xdisp0', 'valid_dxdisp0');

 % Plot the valid initial conditions
figure(1);
plot(valid_xdisp0, valid_dxdisp0,'or','MarkerFaceColor','red','MarkerSize',12);
