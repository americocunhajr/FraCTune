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
ylim([0 0.0035])

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
title('Parameter \lambda2');
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

% Load data results
load('Results_GA_SMC.mat')
    k=Xopt(1);
    lambda1=Xopt(2);
    Xopt_SMC_GA = Xopt;
    sim('SMCControllerCartPendulum.slx');
    x_disp_SMC_GA = xdisp;
    theta_SMC_GA = theta*180/pi;
    usignal_SMC_GA = usignal;
    tout_SMC_GA = tout;
    dtheta_SMC_GA = dtheta;
    F_SMC_GA = Fopt;
    ISX_SMC_GA = trapz(tout,x_disp_SMC_GA.^2);
    ISU_SMC_GA = trapz(tout,usignal_SMC_GA.^2);
    elapsedTime_SMC_GA = elapsedTime;
    F_count_SMC_GA = output.funccount;
load('Results_CE_SMC.mat')   
    k=Xopt(1);
    lambda1=Xopt(2);
    Xopt_SMC_CE = Xopt;
    sim('SMCControllerCartPendulum.slx');
    x_disp_SMC_CE = xdisp;
    theta_SMC_CE = theta*180/pi;
    usignal_SMC_CE = usignal;
    tout_SMC_CE = tout;
    dtheta_SMC_CE = dtheta;
    F_SMC_CE = Fopt;
    ISX_SMC_CE = trapz(tout,x_disp_SMC_CE.^2);
    ISU_SMC_CE = trapz(tout,usignal_SMC_CE.^2);
    elapsedTime_SMC_CE = elapsedTime;
    F_count_SMC_CE = CEobj.Fcount;
load('Results_GA_FOSMC.mat')
    k=Xopt(1);
    lambda1=Xopt(2);
    lambda2=Xopt(3);
    lambda3=Xopt(4);
    OrderD=Xopt(5);
    Xopt_FOSMC_GA = Xopt;
    sim('FOSMCControllerCartPendulum.slx');
    x_disp_FOSMC_GA = xdisp;
    theta_FOSMC_GA = theta*180/pi;
    usignal_FOSMC_GA = usignal;
    tout_FOSMC_GA = tout;
    dtheta_FOSMC_GA = dtheta;
    F_FOSMC_GA = Fopt;
    ISX_FOSMC_GA = trapz(tout,x_disp_FOSMC_GA.^2);
    ISU_FOSMC_GA = trapz(tout,usignal_FOSMC_GA.^2);
    elapsedTime_FOSMC_GA = elapsedTime;
    F_count_FOSMC_GA = output.funccount;
load('Results_CE_FOSMC.mat')   
    k=Xopt(1);
    lambda1=Xopt(2);
    lambda2=Xopt(3);
    lambda3=Xopt(4);
    OrderD=Xopt(5);
    Xopt_FOSMC_CE = Xopt;
    sim('FOSMCControllerCartPendulum.slx');
    x_disp_FOSMC_CE = xdisp;
    theta_FOSMC_CE = theta*180/pi;
    usignal_FOSMC_CE = usignal;
    tout_FOSMC_CE = tout;
    dtheta_FOSMC_CE = dtheta;
    F_FOSMC_CE = Fopt;
    ISX_FOSMC_CE = trapz(tout,x_disp_FOSMC_CE.^2);
    ISU_FOSMC_CE = trapz(tout,usignal_FOSMC_CE.^2);
    elapsedTime_FOSMC_CE = elapsedTime;
    F_count_FOSMC_CE = CEobj.Fcount;

figure(5)
plot(tout_SMC_GA,x_disp_SMC_GA,"-m",'linewidth',6,'DisplayName','SMC + GA');
hold on
plot(tout_SMC_CE,x_disp_SMC_CE,"-b",'linewidth',2,'DisplayName','SMC + CE');
plot(tout_FOSMC_GA,x_disp_FOSMC_GA,"-g",'linewidth',2,'DisplayName','FOSMC + GA');
plot(tout_FOSMC_CE,x_disp_FOSMC_CE,"-r",'linewidth',2,'DisplayName','FOSMC + CE');
plot(tout_FOSMC_CE,(x_disp_FOSMC_CE*0)+2.5,"--k",'linewidth',1,'DisplayName','Restrição');
plot(tout_FOSMC_CE,(x_disp_FOSMC_CE*0)-2.5,"--k",'linewidth',1,'DisplayName','Restrição');
xlabel('Time [seconds]','FontSize', 14);
ylabel('Car Displacement [meters]','FontSize', 14);
ylim([-3 3])
legend('Location','best','FontSize', 12);
ax = gca;
ax.FontSize = 14;

figure(6)
plot(tout_SMC_GA,theta_SMC_GA,"-m",'linewidth',6,'DisplayName','SMC + GA');
hold on
plot(tout_SMC_CE,theta_SMC_CE,"-b",'linewidth',3,'DisplayName','SMC + CE');
plot(tout_FOSMC_GA,theta_FOSMC_GA,"-g",'linewidth',5,'DisplayName','FOSMC + GA');
plot(tout_FOSMC_CE,theta_FOSMC_CE,"-r",'linewidth',3,'DisplayName','FOSMC + CE');
plot(tout_FOSMC_CE,(theta_FOSMC_CE*0),"--k",'linewidth',1,'DisplayName','Referência');
xlabel('Time [seconds]','FontSize', 14);
xlim([0 1.5])
ylabel('Pendulum Angle [degrees]','FontSize', 14);
legend('Location','best','FontSize', 12);
ax = gca;
ax.FontSize = 14;

figure(7)
plot(tout_SMC_GA,usignal_SMC_GA,"-m",'linewidth',6,'DisplayName','SMC + GA');
hold on
plot(tout_SMC_CE,usignal_SMC_CE,"-b",'linewidth',2,'DisplayName','SMC + CE');
plot(tout_FOSMC_GA,usignal_FOSMC_GA,"-g",'linewidth',4,'DisplayName','FOSMC + GA');
plot(tout_FOSMC_CE,usignal_FOSMC_CE,"-r",'linewidth',2,'DisplayName','FOSMC + CE');
xlabel('Time [seconds]','FontSize', 14);
ylabel('Control Signal','FontSize', 14);
legend('Location','best','FontSize', 12);
xlim([0 0.02])
ax = gca;
ax.FontSize = 14;

figure(8)
plot(theta_SMC_GA,dtheta_SMC_GA,"-m",'linewidth',6,'DisplayName','SMC + GA');
hold on
plot(theta_SMC_CE,dtheta_SMC_CE,"-b",'linewidth',2,'DisplayName','SMC + CE');
plot(theta_FOSMC_GA,dtheta_FOSMC_GA,"-g",'linewidth',2,'DisplayName','FOSMC + GA');
plot(theta_FOSMC_CE,dtheta_FOSMC_CE,"-r",'linewidth',2,'DisplayName','FOSMC + CE');
xlabel('Pendulum Angle [degrees]','FontSize', 14);
ylabel('Angular Velocity [rad/s]','FontSize', 14);
legend('Location','best','FontSize', 12);
ax = gca;
ax.FontSize = 14;


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
fprintf(' k_FSMC_GA = %5.5f\n',Xopt_FOSMC_GA(1));
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
disp('Integral of the Square of the Car Displacement:')
fprintf(' ISX_SMC_GA = %5.5f\n',ISX_SMC_GA);
fprintf(' ISX_SMC_CE = %5.5f\n',ISX_SMC_CE);
fprintf(' ISX_FOSMC_GA = %5.5f\n',ISX_FOSMC_GA);
fprintf(' ISX_FOSMC_CE = %5.5f\n',ISX_FOSMC_CE);
disp('--------------------------------------------------------')
disp('Integral of the Square of the Signal Control:')
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