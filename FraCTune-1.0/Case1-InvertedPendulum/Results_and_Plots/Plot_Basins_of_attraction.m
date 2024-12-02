clc; clear; close all;

% LOAD the results
load('Basin_GA_FOSMC.mat');
valid_theta0_GA_FOSMC=valid_theta0;
valid_dtheta0_GA_FOSMC=valid_dtheta0;

load('Basin_CE_FOSMC.mat');
valid_theta0_CE_FOSMC=valid_theta0;
valid_dtheta0_CE_FOSMC=valid_dtheta0;

load('Basin_CE_SMC.mat');
valid_theta0_GA_SMC=valid_theta0;
valid_dtheta0_GA_SMC=valid_dtheta0;

load('Basin_GA_SMC.mat');
valid_theta0_CE_SMC=valid_theta0;
valid_dtheta0_CE_SMC=valid_dtheta0;


% Plot the valid initial conditions
figure(1);
plot(valid_theta0_CE_SMC, valid_dtheta0_CE_SMC, 'ob','DisplayName','SMC + CE','MarkerFaceColor','blue','MarkerSize',12);
hold on
plot(valid_theta0_GA_SMC, valid_dtheta0_GA_SMC, 'om','DisplayName','SMC + GA','MarkerFaceColor','magenta','MarkerSize',8);
plot(valid_theta0_CE_FOSMC, valid_dtheta0_CE_FOSMC, 'or','DisplayName','FOSMC + CE','MarkerFaceColor','red','MarkerSize',12);
plot(valid_theta0_GA_FOSMC, valid_dtheta0_GA_FOSMC, 'og','DisplayName','FOSMC + GA','MarkerFaceColor','green','MarkerSize',8);
xlabel('\theta_0 (graus)','FontSize', 16);
ylabel('d\theta_0 (rad/s)','FontSize', 16);
title('Valid Conditions (\theta_0, d\theta_0) for \theta_{end} < 2^\circ');
grid on;
legend('Location','best','FontSize', 16);
ax = gca;
ax.FontSize = 16;
%print('BasinofAttraction','-dpng')