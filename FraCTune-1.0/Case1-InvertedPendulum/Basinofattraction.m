clc; clear; close all;

disp(' ------------------- ')
disp(' Basinofattraction.m ')
disp(' ------------------- ')

% system parameters
m       = 0.1;
M       = 2.0;
L       = 0.5;
J       = 0.006;
r       = 0.0;
xdisp0  = 0.0;
dxdisp0 = 0.0;

% simulation window
t_end  = 3.0;
dt     = 0.0001;

% auxiliar parameters
A = (M+m)*(J+m*L^2);
B = m*L;
C = M+m;

% Load optimized controller parameters
 load('Results_GA_SMC.mat','Xopt')
% load('Results_CE_SMC.mat','Xopt')
% load('Results_GA_FOSMC.mat','Xopt')
% load('Results_CE_FOSMC.mat','Xopt')
k = Xopt(1);
lambda1 = Xopt(2);
% lambda2 = Xopt(3);
% lambda3 = Xopt(4);
% OrderD = Xopt(5);

% Initial angular velocity (dtheta0) and position (theta0) of the pendulum
% Define ranges of theta0 (degrees) and dtheta0 (rad/s)
theta_range = -60:1:60;  % range of theta0 in degrees
dtheta_range = -15:0.5:15;   % range of dtheta0 in rad/s

% Initialize arrays to store valid initial conditions
valid_theta0 = [];
valid_dtheta0 = [];

% Run simulations over the grid of initial conditions
for theta0_deg = theta_range
    for dtheta0 = dtheta_range
        % Convert theta0 to radians
        theta0 = theta0_deg * pi / 180;

% Run the simulation
            sim('SMCControllerCartPendulum.slx');
           %  sim('FOSMCControllerCartPendulum.slx');

        % Check final value of theta (convert to degrees)
        theta_final_deg = abs(theta(end)) * 180 / pi;
        xdisp_final = max(abs(xdisp));
        
        % If theta_final is less than 10 degrees, store the initial conditions
        if theta_final_deg < 2 && xdisp_final < 2.5
            valid_theta0 = [valid_theta0; theta0_deg]; % Store theta0 in degrees
            valid_dtheta0 = [valid_dtheta0; dtheta0];   % Store dtheta0 in rad/s
        end
    end
end     
 
% Save the results
 save('Basin_GA_SMC.mat'  , 'valid_theta0', 'valid_dtheta0');
% save('Basin_CE_SMC.mat'  , 'valid_theta0', 'valid_dtheta0');
% save('Basin_GA_FOSMC.mat', 'valid_theta0', 'valid_dtheta0');
% save('Basin_CE_FOSMC.mat', 'valid_theta0', 'valid_dtheta0');