close all; clear all; clc;

%% OPTIMIZATION PERFORMANCE
load('GA_FOSMC.mat','J_GA_FOSMC','X_param_GA_FOSMC')
load('Results_CE_FOSMC.mat')
Fbest_CE_FOSMC = CEobj.Fbest;
X_param_CE_FOSMC_xbest = CEobj.xbest;
load('GA_SMC.mat','J_GA_SMC','X_param_GA_SMC')
load('Results_CE_SMC.mat')
Fbest_CE_SMC = CEobj.Fbest;
X_param_CE_SMC_xbest = CEobj.xbest;

figure(1)
plot(J_GA_SMC(:,2),'-m', 'linewidth', 4,'DisplayName','SMC + GA','MarkerFaceColor','magenta','MarkerSize',5);
hold on
plot(Fbest_CE_SMC,'-b', 'linewidth', 4,'DisplayName','SMC + CE','MarkerFaceColor','blue','MarkerSize',5);
plot(J_GA_FOSMC(:,2),'-g', 'linewidth', 4,'DisplayName','FOSMC + GA','MarkerFaceColor','green','MarkerSize',5);
plot(Fbest_CE_FOSMC,'-r', 'linewidth', 4,'DisplayName','FOSMC + CE','MarkerFaceColor','red','MarkerSize',5);
xlabel('For every 100 functions evaluated','FontSize', 14);
ylabel('Optimal Objective Function','FontSize', 14);
legend('Location','best','FontSize', 12);
ax = gca;
ax.FontSize = 14;

figure(2)
plot(J_GA_SMC(:,2),'-m', 'linewidth', 4,'DisplayName','SMC + GA','MarkerFaceColor','magenta','MarkerSize',5);
hold on
plot(Fbest_CE_SMC,'-b', 'linewidth', 4,'DisplayName','SMC + CE','MarkerFaceColor','blue','MarkerSize',5);
plot(J_GA_FOSMC(:,2),'-g', 'linewidth', 4,'DisplayName','FOSMC + GA','MarkerFaceColor','green','MarkerSize',5);
plot(Fbest_CE_FOSMC,'-r', 'linewidth', 4,'DisplayName','FOSMC + CE','MarkerFaceColor','red','MarkerSize',5);
xlabel('For every 100 functions evaluated','FontSize', 14);
ylabel('Optimal Objective Function','FontSize', 14);
legend('Location','best','FontSize', 12);
ax = gca;
ax.FontSize = 14;
ylim([40 70])

figure(3)
subplot(2, 2, 1);% Subplot for the parameter k
plot(X_param_GA_SMC(:,2), "-m", 'linewidth', 2, 'DisplayName', 'SMC + GA');
hold on;
plot(X_param_GA_FOSMC(:,2), "-g", 'linewidth', 2, 'DisplayName', 'FOSMC + GA');
plot(X_param_CE_SMC_xbest(:,1), "-b", 'linewidth', 2, 'DisplayName', 'SMC + CE');
plot(X_param_CE_FOSMC_xbest(:,1), "-r", 'linewidth', 2, 'DisplayName', 'FOSMC + CE');
xlabel('For every 100 functions evaluated','FontSize', 14);
ylabel('k','FontSize', 14);
legend('Location','best','FontSize', 12);
title('Parameter k');
ax = gca;
ax.FontSize = 14;
subplot(2, 2, 2);% Subplot for the parameter lambda1
plot(X_param_GA_SMC(:,3), "-m", 'linewidth', 2, 'DisplayName', 'SMC + GA');
hold on;
plot(X_param_GA_FOSMC(:,3), "-g", 'linewidth', 2, 'DisplayName', 'FOSMC + GA');
plot(X_param_CE_SMC_xbest(:,2), "-b", 'linewidth', 2, 'DisplayName', 'SMC + CE');
plot(X_param_CE_FOSMC_xbest(:,2), "-r", 'linewidth', 2, 'DisplayName', 'FOSMC + CE');
xlabel('For every 100 functions evaluated','FontSize', 14);
ylabel('\lambda1','FontSize', 14);
legend('Location','best','FontSize', 12);
title('Parameter \lambda1');
ax = gca;
ax.FontSize = 14;
subplot(2, 2, 3);% Subplot for the parameter lambda2
plot(X_param_GA_FOSMC(:,4), "-g", 'linewidth', 2, 'DisplayName', 'FOSMC + GA');
hold on;
plot(X_param_CE_FOSMC_xbest(:,3), "-r", 'linewidth', 2, 'DisplayName', 'FOSMC + CE');
xlabel('For every 100 functions evaluated','FontSize', 14);
ylabel('\lambda2','FontSize', 14);
legend('Location','best','FontSize', 12);
title('Parâmetro \lambda2');
ax = gca;
ax.FontSize = 14;
subplot(2, 2, 4);% Subplot for the parameter lambda3
plot(X_param_GA_FOSMC(:,5), "-g", 'linewidth', 2, 'DisplayName', 'FOSMC + GA');
hold on;
plot(X_param_CE_FOSMC_xbest(:,4), "-r", 'linewidth', 2, 'DisplayName', 'FOSMC + CE');
xlabel('For every 100 functions evaluated','FontSize', 14);
ylabel('\lambda3','FontSize', 14);
legend('Location','best','FontSize', 12);
title('Parameter \lambda3');
ax = gca;
ax.FontSize = 14;

figure(4)
plot(X_param_GA_FOSMC(:,6),"-g",'linewidth',2,'DisplayName','FOSMC + GA');
hold on
plot(X_param_CE_FOSMC_xbest(:,5),"-r",'linewidth',2,'DisplayName','FOSMC + CE');
xlabel('For every 100 functions evaluated','FontSize', 14);
ylabel('\alpha','FontSize', 14);
legend('Location','best','FontSize', 12);
ax = gca;
ax.FontSize = 14;

%% SIMULATION RESULTS
clear all; clc;

% system parameters
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

% Load data results
load('Results_GA_FOSMC.mat')
    k=Xopt(1);
    lambda1=Xopt(2);
    lambda2=Xopt(3);
    lambda3=Xopt(4);
    OrderD=Xopt(5);
    Xopt_FOSMC_GA = Xopt;
    sim('FOSMCControllerEH.slx');
    xdisp_FOSMC_GA=xdisp;
    u_FOSMC_GA=u;
    dxdisp_FOSMC_GA=dxdisp;
    v_FOSMC_GA=v;
    % time interval of analysis
    T = time(end)-time(1);
    % output power
    power_FOSMC_GA = lambda.*(v_FOSMC_GA.^2);
    % mean output power
    power_mean_FOSMC_GA = (1/T)*trapz(time,power_FOSMC_GA);
    ISU_FOSMC_GA=trapz(tout,((u_FOSMC_GA.^2)));
    F_FOSMC_GA = Fopt;
    elapsedTime_FOSMC_GA = elapsedTime;
    F_count_FOSMC_GA = output.funccount;
load('Results_CE_FOSMC.mat')    
    k=Xopt(1);
    lambda1=Xopt(2);
    lambda2=Xopt(3);
    lambda3=Xopt(4);
    OrderD=Xopt(5);
    Xopt_FOSMC_CE = Xopt;
    sim('FOSMCControllerEH.slx');
    xdisp_FOSMC_CE=xdisp;
    u_FOSMC_CE=u;
    dxdisp_FOSMC_CE=dxdisp;
    v_FOSMC_CE=v;
    % time interval of analysis
    T = time(end)-time(1);
    % output power
    power_FOSMC_CE = lambda.*(v_FOSMC_CE.^2);
    % mean output power
    power_mean_FOSMC_CE = (1/T)*trapz(time,power_FOSMC_CE);
    ISU_FOSMC_CE=trapz(tout,((u_FOSMC_CE.^2)));
    F_FOSMC_CE = Fopt;
    elapsedTime_FOSMC_CE = elapsedTime;
    F_count_FOSMC_CE = CEobj.Fcount;
load('Results_GA_SMC.mat')
    k=Xopt(1);
    lambda1=Xopt(2);
    Xopt_SMC_GA = Xopt;
    sim('SMCControllerEH.slx');
    xdisp_SMC_GA=xdisp;
    u_SMC_GA=u;
    dxdisp_SMC_GA=dxdisp;
    v_SMC_GA=v;
    % time interval of analysis
    T = time(end)-time(1);
    % output power
    power_SMC_GA = lambda.*(v_SMC_GA.^2);
    % mean output power
    power_mean_SMC_GA = (1/T)*trapz(time,power_SMC_GA);
    ISU_SMC_GA=trapz(tout,((u_SMC_GA.^2)));
    F_SMC_GA = Fopt;
    elapsedTime_SMC_GA = elapsedTime;
    F_count_SMC_GA = output.funccount;
load('Results_CE_SMC.mat')    
    k=Xopt(1);
    lambda1=Xopt(2);
    Xopt_SMC_CE = Xopt;
    sim('SMCControllerEH.slx');
    xdisp_SMC_CE=xdisp;
    u_SMC_CE=u;
    dxdisp_SMC_CE=dxdisp;
    v_SMC_CE=v;
    % time interval of analysis
    T = time(end)-time(1);
    % output power
    power_SMC_CE = lambda.*(v_SMC_CE.^2);
    % mean output power
    power_mean_SMC_CE = (1/T)*trapz(time,power_SMC_CE);
    ISU_SMC_CE=trapz(tout,((u_SMC_CE.^2)));
    F_SMC_CE = Fopt;
    elapsedTime_SMC_CE = elapsedTime;
    F_count_SMC_CE = CEobj.Fcount;

figure(5)
plot3(xdisp_ref,dxdisp_ref,time,'-k','linewidth',2,'DisplayName','Espaço de Fase Referência'); 
hold on
plot3(xdisp_SMC_GA,dxdisp_SMC_GA,time,'-m','linewidth',2,'DisplayName','SMC + GA')
plot3(xdisp_SMC_CE,dxdisp_SMC_CE,time,'-b','linewidth',2,'DisplayName','SMC + CE')
plot3(xdisp_FOSMC_GA,dxdisp_FOSMC_GA,time,'-g','linewidth',2,'DisplayName','FOSMC + GA')
plot3(xdisp_FOSMC_CE,dxdisp_FOSMC_CE,time,'-r','linewidth',2,'DisplayName','FOSMC + CE')
xlabel('Displacement [meters]');
ylabel('Speed ​​[meters/sec]');
zlabel('Time [seconds]');
legend('Location','best');

figure(6)
plot(xdisp_ref,dxdisp_ref,'-k','linewidth',8,'DisplayName','Espaço de Fase Referência'); 
hold on
plot(xdisp_SMC_GA,dxdisp_SMC_GA,'-m','linewidth',6,'DisplayName','SMC + GA')
plot(xdisp_SMC_CE,dxdisp_SMC_CE,'-b','linewidth',4,'DisplayName','SMC + CE')
plot(xdisp_FOSMC_GA,dxdisp_FOSMC_GA,'-g','linewidth',2,'DisplayName','FOSMC + GA')
plot(xdisp_FOSMC_CE,dxdisp_FOSMC_CE,'-r','linewidth',2,'DisplayName','FOSMC + CE')
xlabel('Displacement [meters]');
ylabel('Speed ​​[meters/sec]');
legend('Location','best');

figure(7)
plot(time,u_SMC_GA,'-m','linewidth',2,'DisplayName','SMC + GA'); hold on
plot(time,u_SMC_CE,'-b','linewidth',2,'DisplayName','SMC + CE')
plot(time,u_FOSMC_GA,'-g','linewidth',2,'DisplayName','FOSMC + GA')
plot(time,u_FOSMC_CE,'-r','linewidth',2,'DisplayName','FOSMC + CE')
plot(time,(u_FOSMC_CE*0)+5,"--k",'linewidth',1,'DisplayName','Restrição');
plot(time,(u_FOSMC_CE*0)-5,"--k",'linewidth',1,'DisplayName','Restrição');
xlabel('Time [seconds]');
ylabel('Control Signal');
ylim([-6 6])
legend('Location','best');

figure(8)
plot(time,power_SMC_GA,'-m','linewidth',7,'DisplayName','SMC + GA'); hold on
plot(time,power_SMC_CE,'-b','linewidth',5,'DisplayName','SMC + CE')
plot(time,power_FOSMC_GA,'-g','linewidth',2,'DisplayName','FOSMC + GA');
plot(time,power_FOSMC_CE,'-r','linewidth',2,'DisplayName','FOSMC + CE')
xlabel('Time [seconds]');
ylabel('Generated Power');
legend('Location','best');

figure(9)
plot(time,xdisp_ref,'-k','linewidth',8,'DisplayName','Referencia'); hold on
plot(time,xdisp_SMC_GA,'-m','linewidth',7,'DisplayName','SMC + GA')
plot(time,xdisp_SMC_CE,'-b','linewidth',5,'DisplayName','SMC + CE')
plot(time,xdisp_FOSMC_GA,'-g','linewidth',2,'DisplayName','FOSMC + GA')
plot(time,xdisp_FOSMC_CE,'-r','linewidth',2,'DisplayName','FOSMC + CE')
xlabel('Time [seconds]');
ylabel('Displacement [meters]');
legend('Location','best');

figure(10)
plot(time,dxdisp_ref,'-k','linewidth',8,'DisplayName','Referencia'); hold on
plot(time,dxdisp_SMC_GA,'-m','linewidth',7,'DisplayName','SMC + GA')
plot(time,dxdisp_SMC_CE,'-b','linewidth',5,'DisplayName','SMC + CE')
plot(time,dxdisp_FOSMC_GA,'-g','linewidth',2,'DisplayName','FOSMC + GA')
plot(time,dxdisp_FOSMC_CE,'-r','linewidth',2,'DisplayName','FOSMC + CE')
xlabel('Time [seconds]');
ylabel('Speed ​​[meters/sec]');
legend('Location','best');

figure(11)
subplot(2, 1, 1);
plot(time,xdisp_ref,'-k','linewidth',8,'DisplayName','Referencia'); hold on
plot(time,xdisp_SMC_GA,'-m','linewidth',7,'DisplayName','SMC + GA')
plot(time,xdisp_SMC_CE,'-b','linewidth',5,'DisplayName','SMC + CE')
plot(time,xdisp_FOSMC_GA,'-g','linewidth',2,'DisplayName','FOSMC + GA')
plot(time,xdisp_FOSMC_CE,'-r','linewidth',2,'DisplayName','FOSMC + CE')
xlabel('Time [seconds]');
ylabel('Displacement [meters]');
legend('Location','best');
subplot(2, 1, 2);
plot(time,dxdisp_ref,'-k','linewidth',8,'DisplayName','Referencia'); hold on
plot(time,dxdisp_SMC_GA,'-m','linewidth',7,'DisplayName','SMC + GA')
plot(time,dxdisp_SMC_CE,'-b','linewidth',5,'DisplayName','SMC + CE')
plot(time,dxdisp_FOSMC_GA,'-g','linewidth',2,'DisplayName','FOSMC + GA')
plot(time,dxdisp_FOSMC_CE,'-r','linewidth',2,'DisplayName','FOSMC + CE')
xlabel('Time [seconds]');
ylabel('Speed ​​[meters/sec]');
legend('Location','best');


disp('RESULTS')
disp('--------------------------------------------------------')
disp('Optimal Objective Function:')
fprintf(' F_SMC_GA = %5.9f\n',F_SMC_GA);
fprintf(' F_SMC_CE = %5.9f\n',F_SMC_CE);
fprintf(' F_FOSMC_GA = %5.9f\n',F_FOSMC_GA);
fprintf(' F_FOSMC_CE = %5.9f\n',F_FOSMC_CE);
disp('--------------------------------------------------------')
disp('Optimal Control Parameters:')
fprintf(' k_SMC_GA = %5.5f\n',Xopt_SMC_GA(1));
fprintf(' k_SMC_CE = %5.5f\n',Xopt_SMC_CE(1));
fprintf(' k_FOSMC_GA = %5.5f\n',Xopt_FOSMC_GA(1));
fprintf(' k_FOSMC_CE = %5.5f\n',Xopt_FOSMC_CE(1));
fprintf(' lambda1_SMC_GA = %5.5f\n',Xopt_SMC_GA(2));
fprintf(' lambda1_SMC_CE = %5.5f\n',Xopt_SMC_CE(2));
fprintf(' lambda1_FOSMC_GA = %5.5f\n',Xopt_FOSMC_GA(2));
fprintf(' lambda1_FOSMC_CE = %5.5f\n',Xopt_FOSMC_CE(2));
fprintf(' lambda2_FOSMC_GA = %5.5f\n',Xopt_FOSMC_GA(3));
fprintf(' lambda2_FOSMC_CE = %5.5f\n',Xopt_FOSMC_CE(3));
fprintf(' lambda3_FOSMC_GA = %5.5f\n',Xopt_FOSMC_GA(4));
fprintf(' lambda3_FOSMC_CE = %5.5f\n',Xopt_FOSMC_CE(4));
fprintf(' OrderD_FOSMC_GA = %5.5f\n',Xopt_FOSMC_GA(5));
fprintf(' OrderD_FOSMC_CE = %5.5f\n',Xopt_FOSMC_CE(5));
disp('--------------------------------------------------------')
disp('Average Power:')
fprintf(' power_mean_SMC_GA = %5.5f\n',power_mean_SMC_GA);
fprintf(' power_mean_SMC_CE = %5.5f\n',power_mean_SMC_CE);
fprintf(' power_mean_FOSMC_GA = %5.5f\n',power_mean_FOSMC_GA);
fprintf(' power_mean_FOSMC_CE = %5.5f\n',power_mean_FOSMC_CE);
disp('--------------------------------------------------------')
disp('Integral of the Square of the Control Signal:')
fprintf(' ISU_SMC_GA = %5.5f\n',ISU_SMC_GA);
fprintf(' ISU_SMC_CE = %5.5f\n',ISU_SMC_CE);
fprintf(' ISU_FOSMC_GA = %5.5f\n',ISU_FOSMC_GA);
fprintf(' ISU_FOSMC_CE = %5.5f\n',ISU_FOSMC_CE);
disp('--------------------------------------------------------')
disp('Functions Evaluated:')
fprintf(' F_count_SMC_GA = %5.5f\n',F_count_SMC_GA);
fprintf(' F_count_SMC_CE = %5.5f\n',F_count_SMC_CE);
fprintf(' F_count_FOSMC_GA = %5.5f\n',F_count_FOSMC_GA);
fprintf(' F_count_FOSMC_CE = %5.5f\n',F_count_FOSMC_CE);
disp('--------------------------------------------------------')
disp('Simulation Time:')
fprintf(' elapsedTime_SMC_GA = %5.2f minutes\n',elapsedTime_SMC_GA/60);
fprintf(' elapsedTime_SMC_CE = %5.2f minutes\n',elapsedTime_SMC_CE/60);
fprintf(' elapsedTime_FOSMC_GA = %5.2f minutes\n',elapsedTime_FOSMC_GA/60);
fprintf(' elapsedTime_FOSMC_CE = %5.2f minutes\n',elapsedTime_FOSMC_CE/60);
