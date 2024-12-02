close all; clear all; clc;

%% OPTIMIZATION PERFORMANCE
load('GA_FOPID.mat','J_GA_FOPID','X_param_GA_FOPID')
load('Results_CE_FOPID.mat')
Fbest_CE_FOPID = CEobj.Fbest;
X_param_CE_FOPID_xbest = CEobj.xbest;
load('GA_PID.mat','J_GA_PID','X_param_GA_PID')
load('Results_CE_PID.mat')
Fbest_CE_PID = CEobj.Fbest;
X_param_CE_PID_xbest = CEobj.xbest;

figure(1)
plot(J_GA_PID(:,2),'-m', 'linewidth', 4,'DisplayName','PID + GA','MarkerFaceColor','magenta','MarkerSize',5);
hold on
plot(Fbest_CE_PID,'-b', 'linewidth', 4,'DisplayName','PID + CE','MarkerFaceColor','blue','MarkerSize',5);
plot(J_GA_FOPID(:,2),'-g', 'linewidth', 4,'DisplayName','FOPID + GA','MarkerFaceColor','green','MarkerSize',5);
plot(Fbest_CE_FOPID,'-r', 'linewidth', 4,'DisplayName','FOPID + CE','MarkerFaceColor','red','MarkerSize',5);
xlabel('For every 100 functions evaluate','FontSize', 14);
ylabel('Optimal Objective Function','FontSize', 14);
legend('Location','best','FontSize', 12);
ax = gca;
ax.FontSize = 14;

figure(2)
plot(J_GA_PID(:,2),'-m', 'linewidth', 4,'DisplayName','PID + GA','MarkerFaceColor','magenta','MarkerSize',5);
hold on
plot(Fbest_CE_PID,'-b', 'linewidth', 4,'DisplayName','PID + CE','MarkerFaceColor','blue','MarkerSize',5);
plot(J_GA_FOPID(:,2),'-g', 'linewidth', 4,'DisplayName','FOPID + GA','MarkerFaceColor','green','MarkerSize',5);
plot(Fbest_CE_FOPID,'-r', 'linewidth', 4,'DisplayName','FOPID + CE','MarkerFaceColor','red','MarkerSize',5);
ylim([0.2 0.25])
xlabel('For every 100 functions evaluate','FontSize', 14);
ylabel('Optimal Objective Function','FontSize', 14);
legend('Location','best','FontSize', 12);
ax = gca;
ax.FontSize = 14;

figure(3)
subplot(3, 1, 1);% Subplot for the parameter Kp
plot(X_param_GA_PID(:,2), "-m", 'linewidth', 2, 'DisplayName', 'PID + GA');
hold on;
plot(X_param_GA_FOPID(:,2), "-g", 'linewidth', 2, 'DisplayName', 'FOPID + GA');
plot(X_param_CE_PID_xbest(:,1), "-b", 'linewidth', 2, 'DisplayName', 'PID + CE');
plot(X_param_CE_FOPID_xbest(:,1), "-r", 'linewidth', 2, 'DisplayName', 'FOPID + CE');
%xlabel('For every 100 functions evaluate','FontSize', 14);
ylabel('Kp','FontSize', 14);
legend('Location', 'best','FontSize', 12);
ax = gca;
ax.FontSize = 14;
%title('Parâmetro ki');
subplot(3, 1, 2);% Subplot for the parameter Ki
plot(X_param_GA_PID(:,3), "-m", 'linewidth', 2, 'DisplayName', 'PID + GA');
hold on;
plot(X_param_GA_FOPID(:,3), "-g", 'linewidth', 2, 'DisplayName', 'FOPID + GA');
plot(X_param_CE_PID_xbest(:,2), "-b", 'linewidth', 2, 'DisplayName', 'PID + CE');
plot(X_param_CE_FOPID_xbest(:,2), "-r", 'linewidth', 2, 'DisplayName', 'FOPID + CE');
%xlabel('For every 100 functions evaluate','FontSize', 14);
ylabel('Ki','FontSize', 14);
legend('Location', 'best','FontSize', 12);
ax = gca;
ax.FontSize = 14;
%title('Parâmetro kd');
subplot(3, 1, 3);% Subplot for the parameter kd
plot(X_param_GA_PID(:,4), "-m", 'linewidth', 2, 'DisplayName', 'PID + GA');
hold on;
plot(X_param_GA_FOPID(:,4), "-g", 'linewidth', 2, 'DisplayName', 'FOPID + GA');
plot(X_param_CE_PID_xbest(:,3), "-b", 'linewidth', 2, 'DisplayName', 'PID + CE');
plot(X_param_CE_FOPID_xbest(:,3), "-r", 'linewidth', 2, 'DisplayName', 'FOPID + CE');
xlabel('For every 100 functions evaluate','FontSize', 14);
ylabel('Kd','FontSize', 14);
legend('Location', 'best','FontSize', 12);
ax = gca;
ax.FontSize = 14;

figure(4)
subplot(2, 1, 1)
plot(X_param_GA_FOPID(:,5),"-g",'linewidth',2,'DisplayName','FOPID + GA');
hold on
plot(X_param_CE_FOPID_xbest(:,4),"-r",'linewidth',2,'DisplayName','FOPID + CE');
%xlabel('For every 100 functions evaluate','FontSize', 14);
ylabel('\alpha','FontSize', 14);
legend('Location','best','FontSize', 12);
ax = gca;
ax.FontSize = 14;
subplot(2, 1, 2)
plot(X_param_GA_FOPID(:,6),"-g",'linewidth',2,'DisplayName','FOPID + GA');
hold on
plot(X_param_CE_FOPID_xbest(:,5),"-r",'linewidth',2,'DisplayName','FOPID + CE');
xlabel('For every 100 functions evaluate','FontSize', 14);
ylabel('\beta','FontSize', 14);
legend('Location','best','FontSize', 12);
ax = gca;
ax.FontSize = 14;

%% SIMULATION RESULTS
clear all; clc;

% system parameters
mu = 40;
ms = 250;
ku = 200000;
ks = 10000;
bs = 650;
r  = 0;

% Road profile (m)
load('h.mat','h','desl');
% Travel speed (m/s)
v = 15;
% Observed travel time (s)
t = desl/v;
h = h';
R=0.75;
UC=0.127;

% System without control
Kp  = 0;
Ki  = 0;
Kd  = 0;
OrderI= 1;
OrderD= 1;
sim('ControllerSuspActive.slx');
% Outputs without control
Am2_woutcontrol = Am2;
Fdin_woutcontrol= Fdin;
Ds_woutcontrol  = Ds;
Zs_woutcontrol  = Zs;
Zu_woutcontrol  = Zu;
Vs_woutcontrol  = Vs;
Vu_woutcontrol  = Vu;
u_woutcontrol   = u;
% Results
rms_Am2_woutcontrol = rms(Am2_woutcontrol(1/10*end:end));
ISZs_woutcontrol    = trapz(tout(1/10*end:end),Zs_woutcontrol(1/10*end:end).^2);
ISU_woutcontrol     = trapz(tout,((u_woutcontrol.^2)));
cons_Fdin_woutcontrol = abs(min(Fdin_woutcontrol(1/10*end:end))) - ((1-R)*ms*9.81);
cons_Ds_woutcontrol   = max(abs(Ds_woutcontrol)) - UC/2;

% Load data results
load('Results_GA_PID.mat')
Kp = Xopt(1);
Ki = Xopt(2);
Kd = Xopt(3);
Xopt_PID_GA = Xopt;
sim('ControllerSuspActive.slx');
% Outputs
Am2_PID_GA  = Am2;
Fdin_PID_GA = Fdin;
Ds_PID_GA   = Ds;
Zs_PID_GA   = Zs;
Zu_PID_GA   = Zu;
Vs_PID_GA   = Vs;
Vu_PID_GA   = Vu;
u_PID_GA    = u;
% Results
rms_Am2_PID_GA     = rms(Am2_PID_GA(1/10*end:end));
ISZs_PID_GA        = trapz(tout(1/10*end:end),Zs_PID_GA(1/10*end:end).^2);
ISU_PID_GA         = trapz(tout,((u_PID_GA.^2)));
cons_Fdin_PID_GA   = abs(min(Fdin_PID_GA(1/10*end:end))) - ((1-R)*ms*9.81);
cons_Ds_PID_GA     = max(abs(Ds_PID_GA)) - UC/2;
F_PID_GA           = Fopt;
elapsedTime_PID_GA = elapsedTime;
F_count_PID_GA     = output.funccount;

% Load data results
load('Results_CE_PID.mat')    
Kp = Xopt(1);
Ki = Xopt(2);
Kd = Xopt(3);
Xopt_PID_CE = Xopt;
sim('ControllerSuspActive.slx');
% Outputs
Am2_PID_CE  = Am2;
Fdin_PID_CE = Fdin;
Ds_PID_CE   = Ds;
Zs_PID_CE   = Zs;
Zu_PID_CE   = Zu;
Vs_PID_CE   = Vs;
Vu_PID_CE   = Vu;
u_PID_CE    = u;
% Results
rms_Am2_PID_CE     = rms(Am2_PID_CE(1/10*end:end));
ISZs_PID_CE        = trapz(tout(1/10*end:end),Zs_PID_CE(1/10*end:end).^2);
ISU_PID_CE         = trapz(tout,((u_PID_CE.^2)));
cons_Fdin_PID_CE   = abs(min(Fdin_PID_CE(1/10*end:end))) - ((1-R)*ms*9.81);
cons_Ds_PID_CE     = max(abs(Ds_PID_CE)) - UC/2;
F_PID_CE           = Fopt;
elapsedTime_PID_CE = elapsedTime;
F_count_PID_CE     = CEobj.Fcount;

% Load data results
load('Results_GA_FOPID.mat')
Kp = Xopt(1);
Ki = Xopt(2);
Kd = Xopt(3);
OrderI = Xopt(4);
OrderD = Xopt(5);
Xopt_FOPID_GA = Xopt;
sim('ControllerSuspActive.slx');
% Outputs
Am2_FOPID_GA  = Am2;
Fdin_FOPID_GA = Fdin;
Ds_FOPID_GA   = Ds;
Zs_FOPID_GA   = Zs;
Zu_FOPID_GA   = Zu;
Vs_FOPID_GA   = Vs;
Vu_FOPID_GA   = Vu;
u_FOPID_GA    = u;
% Results
rms_Am2_FOPID_GA     = rms(Am2_FOPID_GA(1/10*end:end));
ISZs_FOPID_GA        = trapz(tout(1/10*end:end),Zs_FOPID_GA(1/10*end:end).^2);
ISU_FOPID_GA         = trapz(tout,((u_FOPID_GA.^2)));
cons_Fdin_FOPID_GA   = abs(min(Fdin_FOPID_GA(1/10*end:end))) - ((1-R)*ms*9.81);
cons_Ds_FOPID_GA     = max(abs(Ds_FOPID_GA)) - UC/2;
F_FOPID_GA           = Fopt;
elapsedTime_FOPID_GA = elapsedTime;
F_count_FOPID_GA     = output.funccount;

% Load data results
load('Results_CE_FOPID.mat')    
Kp = Xopt(1);
Ki = Xopt(2);
Kd = Xopt(3);
OrderI = Xopt(4);
OrderD = Xopt(5);
Xopt_FOPID_CE = Xopt;
sim('ControllerSuspActive.slx');
% Outputs
Am2_FOPID_CE  = Am2;
Fdin_FOPID_CE = Fdin;
Ds_FOPID_CE = Ds;
Zs_FOPID_CE = Zs;
Zu_FOPID_CE = Zu;
Vs_FOPID_CE = Vs;
Vu_FOPID_CE = Vu;
u_FOPID_CE  = u;
% Results
rms_Am2_FOPID_CE     = rms(Am2_FOPID_CE(1/10*end:end));
ISZs_FOPID_CE        = trapz(tout(1/10*end:end),Zs_FOPID_CE(1/10*end:end).^2);
ISU_FOPID_CE         = trapz(tout,((u_FOPID_CE.^2)));
cons_Fdin_FOPID_CE   = abs(min(Fdin_FOPID_CE(1/10*end:end))) - ((1-R)*ms*9.81);
cons_Ds_FOPID_CE     = max(abs(Ds_FOPID_CE)) - UC/2;
F_FOPID_CE           = Fopt;
elapsedTime_FOPID_CE = elapsedTime;
F_count_FOPID_CE     = CEobj.Fcount;

%% PLOTTING RESULTS
figure(5)
plot(desl,Am2_woutcontrol,'-k','linewidth',3,'DisplayName','Sem controle'); 
hold on
plot(desl,Am2_PID_GA,'-m','linewidth',3,'DisplayName','PID + GA')
plot(desl,Am2_PID_CE,'-b','linewidth',3,'DisplayName','PID + CE')
plot(desl,Am2_FOPID_GA,'-g','linewidth',2,'DisplayName','FOPID + GA')
plot(desl,Am2_FOPID_CE,'-r','linewidth',2,'DisplayName','FOPID + CE')
xlabel('Road distance [meters]','FontSize', 14);
ylabel('Chassis Vert. Acceleration [meters/sec]','FontSize', 14);
legend('Location','best','FontSize', 12);
ylim([-1 1])
ax = gca;
ax.FontSize = 14;

figure(6)
plot(desl,Zs_woutcontrol,'-k','linewidth',2,'DisplayName','Sem controle'); 
hold on
plot(desl,Zs_PID_GA,'-m','linewidth',2,'DisplayName','PID + GA')
plot(desl,Zs_PID_CE,'-b','linewidth',2,'DisplayName','PID + CE')
plot(desl,Zs_FOPID_GA,'-g','linewidth',2,'DisplayName','FOPID + GA')
plot(desl,Zs_FOPID_CE,'-r','linewidth',2,'DisplayName','FOPID + CE')
xlabel('Road distance [meters]','FontSize', 14);
ylabel('Chassis Vert. Displacement [meters]','FontSize', 14);
legend('Location','best','FontSize', 12);
ax = gca;
ax.FontSize = 14;

figure(7)
plot(desl,Fdin_woutcontrol,'-k','linewidth',2,'DisplayName','Sem controle'); 
hold on
plot(desl,(Fdin_FOPID_CE*0)-((1-R)*ms*9.81),':k','linewidth',2,'DisplayName','Restrição')
plot(desl,Fdin_PID_GA,'-m','linewidth',3,'DisplayName','PID + GA')
plot(desl,Fdin_PID_CE,'-b','linewidth',3,'DisplayName','PID + CE')
plot(desl,Fdin_FOPID_GA,'-g','linewidth',3,'DisplayName','FOPID + GA')
plot(desl,Fdin_FOPID_CE,'-r','linewidth',2,'DisplayName','FOPID + CE')
xlabel('Road distance [meters]','FontSize', 14);
ylabel('Vertical Dynamic Force [N]','FontSize', 14);
legend('Location','best','FontSize', 12);
ylim([-750 750])
ax = gca;
ax.FontSize = 14;

figure(8)
plot(desl,u_PID_GA,'-m','linewidth',2,'DisplayName','PID + GA')
hold on
plot(desl,u_PID_CE,'-b','linewidth',2,'DisplayName','PID + CE')
plot(desl,u_FOPID_GA,'-g','linewidth',2,'DisplayName','FOPID + GA')
plot(desl,u_FOPID_CE,'-r','linewidth',2,'DisplayName','FOPID + CE')
xlabel('Road distance [meters]','FontSize', 14);
ylabel('Control Signal [N]','FontSize', 14);
legend('Location','best','FontSize', 12);
ax = gca;
ax.FontSize = 14;

figure(9)
plot(desl,Ds_woutcontrol,'-k','linewidth',2,'DisplayName','Sem controle'); 
hold on
plot(desl,(Ds_FOPID_CE*0)+UC/2,':k','linewidth',2,'DisplayName','Restrição')
plot(desl,Ds_PID_GA,'-m','linewidth',2,'DisplayName','PID + GA')
plot(desl,Ds_PID_CE,'-b','linewidth',2,'DisplayName','PID + CE')
plot(desl,Ds_FOPID_GA,'-g','linewidth',2,'DisplayName','FOPID + GA')
plot(desl,Ds_FOPID_CE,'-r','linewidth',2,'DisplayName','FOPID + CE')
xlabel('Road distance [meters]','FontSize', 14);
ylabel('Suspension Deflection [meters]','FontSize', 14);
legend('Location','best','FontSize', 12);
ax = gca;
ax.FontSize = 14;

disp('RESULTS')
disp('--------------------------------------------------------')
disp('Optimal Objective Function:')
fprintf(' F_PID_GA = %5.9f\n',F_PID_GA);
fprintf(' F_PID_CE = %5.9f\n',F_PID_CE);
fprintf(' F_FOPID_GA = %5.9f\n',F_FOPID_GA);
fprintf(' F_FOPID_CE = %5.9f\n',F_FOPID_CE);
disp('--------------------------------------------------------')
disp('Optimal Control Parameters:')
fprintf(' Kp_PID_GA = %5.5f\n',Xopt_PID_GA(1));
fprintf(' Kp_PID_CE = %5.5f\n',Xopt_PID_CE(1));
fprintf(' Kp_FOPID_GA = %5.5f\n',Xopt_FOPID_GA(1));
fprintf(' Kp_FOPID_CE = %5.5f\n',Xopt_FOPID_CE(1));
fprintf(' Ki_PID_GA = %5.5f\n',Xopt_PID_GA(2));
fprintf(' Ki_PID_CE = %5.5f\n',Xopt_PID_CE(2));
fprintf(' Ki_FOPID_GA = %5.5f\n',Xopt_FOPID_GA(2));
fprintf(' Ki_FOPID_CE = %5.5f\n',Xopt_FOPID_CE(2));
fprintf(' Kp_PID_GA = %5.5f\n',Xopt_PID_GA(3));
fprintf(' Kp_PID_CE = %5.5f\n',Xopt_PID_CE(3));
fprintf(' Kp_FOPID_GA = %5.5f\n',Xopt_FOPID_GA(3));
fprintf(' Kp_FOPID_CE = %5.5f\n',Xopt_FOPID_CE(3));
fprintf(' OrderI_FOPID_GA = %5.5f\n',Xopt_FOPID_GA(4));
fprintf(' OrderI_FOPID_CE = %5.5f\n',Xopt_FOPID_CE(4));
fprintf(' OrderD_FOPID_GA = %5.5f\n',Xopt_FOPID_GA(5));
fprintf(' OrderD_FOPID_CE = %5.5f\n',Xopt_FOPID_CE(5));
disp('--------------------------------------------------------')
disp('RMS Chassis Vertical Acceleration')
fprintf(' rms_Am2_PID_GA = %5.5f\n',rms_Am2_PID_GA);
fprintf(' rms_Am2_PID_CE = %5.5f\n',rms_Am2_PID_CE);
fprintf(' rms_Am2_FOPID_GA = %5.5f\n',rms_Am2_FOPID_GA);
fprintf(' rms_Am2_FOPID_CE = %5.5f\n',rms_Am2_FOPID_CE);
disp('--------------------------------------------------------')
disp('Integral of the Square of the Control Signal:')
fprintf(' ISU_PID_GA = %5.5f\n',ISU_PID_GA);
fprintf(' ISU_PID_CE = %5.5f\n',ISU_PID_CE);
fprintf(' ISU_FOPID_GA = %5.5f\n',ISU_FOPID_GA);
fprintf(' ISU_FOPID_CE = %5.5f\n',ISU_FOPID_CE);
disp('--------------------------------------------------------')
disp('Integral of the Square of the Chassis Vertical Displacement:')
fprintf(' ISZs_PID_GA = %5.5f\n',ISZs_PID_GA);
fprintf(' ISZs_PID_CE = %5.5f\n',ISZs_PID_CE);
fprintf(' ISZs_FOPID_GA = %5.5f\n',ISZs_FOPID_GA);
fprintf(' ISZs_FOPID_CE = %5.5f\n',ISZs_FOPID_CE);
disp('--------------------------------------------------------')
disp('Vertical Dynamic Force Constraint:')
fprintf(' cons_Fdin_PID_GA = %5.5f\n',cons_Fdin_PID_GA);
fprintf(' cons_Fdin_PID_CE = %5.5f\n',cons_Fdin_PID_CE);
fprintf(' cons_Fdin_FOPID_GA = %5.5f\n',cons_Fdin_FOPID_GA);
fprintf(' cons_Fdin_FOPID_CE = %5.5f\n',cons_Fdin_FOPID_CE);
disp('--------------------------------------------------------')
disp('Suspension Deflection Constraint:')
fprintf(' cons_Ds_PID_GA = %5.5f\n',cons_Ds_PID_GA);
fprintf(' cons_Ds_PID_CE = %5.5f\n',cons_Ds_PID_CE);
fprintf(' cons_Ds_FOPID_GA = %5.5f\n',cons_Ds_FOPID_GA);
fprintf(' cons_Ds_FOPID_CE = %5.5f\n',cons_Ds_FOPID_CE);
disp('--------------------------------------------------------')
disp('Functions Evaluated:')
fprintf(' F_count_PID_GA = %5.5f\n',F_count_PID_GA);
fprintf(' F_count_PID_CE = %5.5f\n',F_count_PID_CE);
fprintf(' F_count_FOPID_GA = %5.5f\n',F_count_FOPID_GA);
fprintf(' F_count_FOPID_CE = %5.5f\n',F_count_FOPID_CE);
disp('--------------------------------------------------------')
disp('Simulation Time:')
fprintf(' elapsedTime_PID_GA = %5.2f minutes\n',elapsedTime_PID_GA/60);
fprintf(' elapsedTime_PID_CE = %5.2f minutes\n',elapsedTime_PID_CE/60);
fprintf(' elapsedTime_FOPID_GA = %5.2f minutes\n',elapsedTime_FOPID_GA/60);
fprintf(' elapsedTime_FOPID_CE = %5.2f minutes\n',elapsedTime_FOPID_CE/60);
