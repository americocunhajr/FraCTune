clc; clear; close all;

% Load the results
load('Basin_GA_FOSMC.mat');
valid_xdisp0_GA_FOSMC  = valid_xdisp0;
valid_dxdisp0_GA_FOSMC = valid_dxdisp0;

load('Basin_CE_FOSMC.mat');
valid_xdisp0_CE_FOSMC  = valid_xdisp0;
valid_dxdisp0_CE_FOSMC = valid_dxdisp0;

load('Basin_CE_SMC.mat');
valid_xdisp0_GA_SMC    = valid_xdisp0;
valid_dxdisp0_GA_SMC   = valid_dxdisp0;

load('Basin_GA_SMC.mat');
valid_xdisp0_CE_SMC    = valid_xdisp0;
valid_dxdisp0_CE_SMC   = valid_dxdisp0;

% Plot the valid initial conditions
figure(1);
plot(valid_xdisp0_CE_FOSMC, valid_dxdisp0_CE_FOSMC, 'or','DisplayName','FOSMC + CE','MarkerFaceColor','red','MarkerSize',6);
hold on
plot(valid_xdisp0_GA_SMC, valid_dxdisp0_GA_SMC, 'om','DisplayName','SMC + GA','MarkerFaceColor','magenta','MarkerSize',12);
plot(valid_xdisp0_CE_SMC, valid_dxdisp0_CE_SMC, 'ob','DisplayName','SMC + CE','MarkerFaceColor','blue','MarkerSize',6);
plot(valid_xdisp0_GA_FOSMC, valid_dxdisp0_GA_FOSMC, 'og','DisplayName','FOSMC + GA','MarkerFaceColor','green','MarkerSize',12);
xlabel('xdisp_0 (m)','FontSize', 12);
ylabel('dxdisp_0 (m/s)','FontSize', 12);
title('Valid Conditions (xdisp_{0}, dxdisp_{0}) para u_{end} < 5');
grid on;
legend('Location','best','FontSize', 12);
xlim([0.75 1.25])
ax = gca;
ax.FontSize = 12;