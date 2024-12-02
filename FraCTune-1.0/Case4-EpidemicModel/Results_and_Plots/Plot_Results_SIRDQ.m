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
xlabel('For every 100 functions evaluated','FontSize', 14);
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
xlabel('For every 100 functions evaluated','FontSize', 14);
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
ylabel('Kp','FontSize', 14);
legend('Location', 'best','FontSize', 12);
ax = gca;
ax.FontSize = 14;
subplot(3, 1, 2);% Subplot for the parameter Ki
plot(X_param_GA_PID(:,3), "-m", 'linewidth', 2, 'DisplayName', 'PID + GA');
hold on;
plot(X_param_GA_FOPID(:,3), "-g", 'linewidth', 2, 'DisplayName', 'FOPID + GA');
plot(X_param_CE_PID_xbest(:,2), "-b", 'linewidth', 2, 'DisplayName', 'PID + CE');
plot(X_param_CE_FOPID_xbest(:,2), "-r", 'linewidth', 2, 'DisplayName', 'FOPID + CE');
ylabel('Ki','FontSize', 14);
legend('Location', 'best','FontSize', 12);
ax = gca;
ax.FontSize = 14;
subplot(3, 1, 3);% Subplot for the parameter kd
plot(X_param_GA_PID(:,4), "-m", 'linewidth', 2, 'DisplayName', 'PID + GA');
hold on;
plot(X_param_GA_FOPID(:,4), "-g", 'linewidth', 2, 'DisplayName', 'FOPID + GA');
plot(X_param_CE_PID_xbest(:,3), "-b", 'linewidth', 2, 'DisplayName', 'PID + CE');
plot(X_param_CE_FOPID_xbest(:,3), "-r", 'linewidth', 2, 'DisplayName', 'FOPID + CE');
xlabel('For every 100 functions evaluated','FontSize', 14);
ylabel('Kd','FontSize', 14);
legend('Location', 'best','FontSize', 12);
ax = gca;
ax.FontSize = 14;

figure(4)
subplot(2, 1, 1)
plot(X_param_GA_FOPID(:,5),"-g",'linewidth',2,'DisplayName','FOPID + GA');
hold on
plot(X_param_CE_FOPID_xbest(:,4),"-r",'linewidth',2,'DisplayName','FOPID + CE');
ylabel('\alpha','FontSize', 14);
legend('Location','best','FontSize', 12);
ax = gca;
ax.FontSize = 14;
subplot(2, 1, 2)
plot(X_param_GA_FOPID(:,6),"-g",'linewidth',2,'DisplayName','FOPID + GA');
hold on
plot(X_param_CE_FOPID_xbest(:,5),"-r",'linewidth',2,'DisplayName','FOPID + CE');
xlabel('For every 100 functions evaluated','FontSize', 14);
ylabel('\beta','FontSize', 14);
legend('Location','best','FontSize', 12);
ax = gca;
ax.FontSize = 14;

%% SIMULATION RESULTS
clear all; clc;

% system parameters
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

% System without control
Kp     = 0;
Ki     = 0;
Kd     = 0;
OrderI = 1;
OrderD = 1;
sim('ControllerSIRDQ.slx');
% Outputs
S_woutcontrol = S;
I_woutcontrol = I;
R_woutcontrol = R;
D_woutcontrol = D;
Q_woutcontrol = Q;
C_woutcontrol = C;
R0_woutcontrol = R0;
usignal_woutcontrol = usignal;
% Results
cons_u_minor1_woutcontrol = max(usignal) - 1;
cons_u_major0_woutcontrol = -min(usignal);
cons_quarantined_woutcontrol = max(Q) - 0.6*N;

% Load data results
load('Results_GA_FOPID.mat')
Kp     = Xopt(1);
Ki     = Xopt(2);
Kd     = Xopt(3);
OrderI = Xopt(4);
OrderD = Xopt(5);
Xopt_FOPID_GA = Xopt;
sim('ControllerSIRDQ.slx');
% Outputs
S_FOPID_GA = S;
I_FOPID_GA = I;
R_FOPID_GA = R;
D_FOPID_GA = D;
Q_FOPID_GA = Q;
C_FOPID_GA = C;
R0_FOPID_GA = R0;
usignal_FOPID_GA = usignal;
% Results
ISU_FOPID_GA                = trapz(tout,((usignal_FOPID_GA.^2)));
ISQ_FOPID_GA                = trapz(tout,Q_FOPID_GA.^2);
ISI_FOPID_GA                = trapz(tout,I_FOPID_GA.^2);
cons_u_minor1_FOPID_GA      = max(usignal_FOPID_GA) - 1;
cons_u_major0_FOPID_GA      = -min(usignal_FOPID_GA);
cons_quarantined_FOPID_GA = max(Q_FOPID_GA) - 0.6*N;
F_FOPID_GA           = Fopt;
elapsedTime_FOPID_GA = elapsedTime;
F_count_FOPID_GA     = output.funccount;

% Load data results
load('Results_CE_FOPID.mat')    
Kp     = Xopt(1);
Ki     = Xopt(2);
Kd     = Xopt(3);
OrderI = Xopt(4);
OrderD = Xopt(5);
Xopt_FOPID_CE = Xopt;
sim('ControllerSIRDQ.slx');
% Outputs
S_FOPID_CE = S;
I_FOPID_CE = I;
R_FOPID_CE = R;
D_FOPID_CE = D;
Q_FOPID_CE = Q;
C_FOPID_CE = C;
R0_FOPID_CE = R0;
usignal_FOPID_CE = usignal;
% Results
ISU_FOPID_CE                = trapz(tout,((usignal_FOPID_CE.^2)));
ISQ_FOPID_CE                = trapz(tout,Q_FOPID_CE.^2);
ISI_FOPID_CE                = trapz(tout,I_FOPID_CE.^2);
cons_u_minor1_FOPID_CE      = max(usignal_FOPID_CE) - 1;
cons_u_major0_FOPID_CE      = -min(usignal_FOPID_CE);
cons_quarantined_FOPID_CE = max(Q_FOPID_CE) - 0.6*N;
F_FOPID_CE           = Fopt;
elapsedTime_FOPID_CE = elapsedTime;
F_count_FOPID_CE     = CEobj.Fcount;

% Load data results
load('Results_GA_PID.mat')
Kp     = Xopt(1);
Ki     = Xopt(2);
Kd     = Xopt(3);
Xopt_PID_GA = Xopt;
sim('ControllerSIRDQ.slx');
% Outputs
S_PID_GA = S;
I_PID_GA = I;
R_PID_GA = R;
D_PID_GA = D;
Q_PID_GA = Q;
C_PID_GA = C;
R0_PID_GA = R0;
usignal_PID_GA = usignal;
% Results
ISU_PID_GA                = trapz(tout,((usignal_PID_GA.^2)));
ISQ_PID_GA                = trapz(tout,Q_PID_GA.^2);
ISI_PID_GA                = trapz(tout,I_PID_GA.^2);
cons_u_minor1_PID_GA      = max(usignal_PID_GA) - 1;
cons_u_major0_PID_GA      = -min(usignal_PID_GA);
cons_quarantined_PID_GA = max(Q_PID_GA) - 0.6*N;
F_PID_GA           = Fopt;
elapsedTime_PID_GA = elapsedTime;
F_count_PID_GA     = output.funccount;

% Load data results
load('Results_CE_PID.mat')    
Kp     = Xopt(1);
Ki     = Xopt(2);
Kd     = Xopt(3);
Xopt_PID_CE = Xopt;
sim('ControllerSIRDQ.slx');
% Outputs
S_PID_CE = S;
I_PID_CE = I;
R_PID_CE = R;
D_PID_CE = D;
Q_PID_CE = Q;
C_PID_CE = C;
R0_PID_CE = R0;
usignal_PID_CE = usignal;
% Results
ISU_PID_CE                = trapz(tout,((usignal_PID_CE.^2)));
ISI_PID_CE                = trapz(tout,I_PID_CE.^2);
ISQ_PID_CE                = trapz(tout,Q_PID_CE.^2);
cons_u_minor1_PID_CE      = max(usignal_PID_CE) - 1;
cons_u_major0_PID_CE      = -min(usignal_PID_CE);
cons_quarantined_PID_CE = max(Q_PID_CE) - 0.6*N;
F_PID_CE           = Fopt;
elapsedTime_PID_CE = elapsedTime;
F_count_PID_CE     = CEobj.Fcount;
                        
%% PLOTTING RESULTS
figure(5)
plot(tout,S_woutcontrol,'-k','linewidth',2,'DisplayName','Sem controle');
hold on
plot(tout,S_PID_GA,'-m','linewidth',2,'DisplayName','PID + GA');
plot(tout,S_PID_CE,'-b','linewidth',2,'DisplayName','PID + CE');
plot(tout,S_FOPID_GA,'-g','linewidth',2,'DisplayName','FOPID + GA');
plot(tout,S_FOPID_CE,'-r','linewidth',2,'DisplayName','FOPID + CE')
xlabel('Time [days]','FontSize', 14);
ylabel('Susceptible','FontSize', 14);
legend('Location','best','FontSize', 12);

figure(6)
plot(tout,I_woutcontrol,'-k','linewidth',2,'DisplayName','Sem controle');
hold on
plot(tout,I_PID_GA,'-m','linewidth',2,'DisplayName','PID + GA');
plot(tout,I_PID_CE,'-b','linewidth',2,'DisplayName','PID + CE');
plot(tout,I_FOPID_GA,'-g','linewidth',2,'DisplayName','FOPID + GA');
plot(tout,I_FOPID_CE,'-r','linewidth',2,'DisplayName','FOPID + CE')
xlabel('Time [days]','FontSize', 14);
ylabel('Infected','FontSize', 14);
legend('Location','best','FontSize', 12);

figure(7)
plot(tout,R_woutcontrol,'-k','linewidth',2,'DisplayName','Sem controle');
hold on
plot(tout,R_PID_GA,'-m','linewidth',2,'DisplayName','PID + GA');
plot(tout,R_PID_CE,'-b','linewidth',2,'DisplayName','PID + CE');
plot(tout,R_FOPID_GA,'-g','linewidth',2,'DisplayName','FOPID + GA');
plot(tout,R_FOPID_CE,'-r','linewidth',2,'DisplayName','FOPID + CE')
xlabel('Time [days]','FontSize', 14);
ylabel('Recovered','FontSize', 14);
legend('Location','best','FontSize', 12);

figure(8)
plot(tout,D_woutcontrol,'-k','linewidth',2,'DisplayName','Sem controle');
hold on
plot(tout,D_PID_GA,'-m','linewidth',2,'DisplayName','PID + GA');
plot(tout,D_PID_CE,'-b','linewidth',2,'DisplayName','PID + CE');
plot(tout,D_FOPID_GA,'-g','linewidth',2,'DisplayName','FOPID + GA');
plot(tout,D_FOPID_CE,'-r','linewidth',2,'DisplayName','FOPID + CE')
xlabel('Time [days]','FontSize', 14);
ylabel('Dead','FontSize', 14);
legend('Location','best','FontSize', 12);

figure(9)
plot(tout,Q_woutcontrol,'-k','linewidth',2,'DisplayName','Sem controle');
hold on
plot(tout,(Q_FOPID_CE*0)+0.6*N,":k",'linewidth',2,'DisplayName','Restrição');
plot(tout,Q_PID_GA,'-m','linewidth',2,'DisplayName','PID + GA');
plot(tout,Q_PID_CE,'-b','linewidth',2,'DisplayName','PID + CE');
plot(tout,Q_FOPID_GA,'-g','linewidth',2,'DisplayName','FOPID + GA');
plot(tout,Q_FOPID_CE,'-r','linewidth',2,'DisplayName','FOPID + CE')
xlabel('Time [days]','FontSize', 14);
ylabel('Quarantined','FontSize', 14);
legend('Location','best','FontSize', 12);

figure(10)
plot(tout,C_woutcontrol,'-k','linewidth',2,'DisplayName','Sem controle');
hold on
plot(tout,C_PID_GA,'-m','linewidth',2,'DisplayName','PID + GA');
plot(tout,C_PID_CE,'-b','linewidth',2,'DisplayName','PID + CE');
plot(tout,C_FOPID_GA,'-g','linewidth',2,'DisplayName','FOPID + GA');
plot(tout,C_FOPID_CE,'-r','linewidth',2,'DisplayName','FOPID + CE')
xlabel('Time [days]','FontSize', 14);
ylabel('Accumulated Infected','FontSize', 14);
legend('Location','best','FontSize', 12);

figure(11)
plot(tout,usignal_woutcontrol,'-k','linewidth',2,'DisplayName','Sem controle');
hold on
plot(tout,(usignal_FOPID_CE*0)+1,":k",'linewidth',2,'DisplayName','Restrição');
plot(tout,usignal_PID_GA,'-m','linewidth',2,'DisplayName','PID + GA');
plot(tout,usignal_PID_CE,'-b','linewidth',2,'DisplayName','PID + CE');
plot(tout,usignal_FOPID_GA,'-g','linewidth',2,'DisplayName','FOPID + GA');
plot(tout,usignal_FOPID_CE,'-r','linewidth',2,'DisplayName','FOPID + CE')
xlabel('Time [days]','FontSize', 14);
ylabel('Control Signal','FontSize', 14);
legend('Location','best','FontSize', 12);

figure(12)
plot(tout,R0_woutcontrol,'-k','linewidth',2,'DisplayName','Sem controle');
hold on
plot(tout,(R0_FOPID_CE*0)+1,":k",'linewidth',2,'DisplayName','Limite controle epidemia');
plot(tout,R0_PID_GA,'-m','linewidth',2,'DisplayName','PID + GA');
plot(tout,R0_PID_CE,'-b','linewidth',2,'DisplayName','PID + CE');
plot(tout,R0_FOPID_GA,'-g','linewidth',2,'DisplayName','FOPID + GA');
plot(tout,R0_FOPID_CE,'-r','linewidth',2,'DisplayName','FOPID + CE')
xlabel('Time [days]','FontSize', 14);
ylabel('Basic Reproduction Number','FontSize', 14);
legend('Location','best','FontSize', 12);

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
disp('Integral of the Square of the Signal Control:')
fprintf(' ISU_PID_GA = %5.5f\n',ISU_PID_GA);
fprintf(' ISU_PID_CE = %5.5f\n',ISU_PID_CE);
fprintf(' ISU_FOPID_GA = %5.5f\n',ISU_FOPID_GA);
fprintf(' ISU_FOPID_CE = %5.5f\n',ISU_FOPID_CE);
disp('--------------------------------------------------------')
disp('Integral of the Square of the Infected:')
fprintf(' ISI_PID_GA = %5.5f\n',ISI_PID_GA);
fprintf(' ISI_PID_CE = %5.5f\n',ISI_PID_CE);
fprintf(' ISI_FOPID_GA = %5.5f\n',ISI_FOPID_GA);
fprintf(' ISI_FOPID_CE = %5.5f\n',ISI_FOPID_CE);
disp('--------------------------------------------------------')
disp('Integral of the Square of the Quarantined:')
fprintf(' ISQ_PID_GA = %5.5f\n',ISQ_PID_GA);
fprintf(' ISQ_PID_CE = %5.5f\n',ISQ_PID_CE);
fprintf(' ISQ_FOPID_GA = %5.5f\n',ISQ_FOPID_GA);
fprintf(' ISQ_FOPID_CE = %5.5f\n',ISQ_FOPID_CE);
disp('--------------------------------------------------------')
disp('Constraint Control Signal:')
fprintf(' cons_u_minor1_PID_GA = %5.5f\n',cons_u_minor1_PID_GA);
fprintf(' cons_u_minor1_PID_CE = %5.5f\n',cons_u_minor1_PID_CE);
fprintf(' cons_u_minor1_FOPID_GA = %5.5f\n',cons_u_minor1_FOPID_GA);
fprintf(' cons_u_minor1_FOPID_CE = %5.5f\n',cons_u_minor1_FOPID_CE);
fprintf(' cons_u_major0_PID_GA = %5.5f\n',cons_u_major0_PID_GA);
fprintf(' cons_u_major0_PID_CE = %5.5f\n',cons_u_major0_PID_CE);
fprintf(' cons_u_major0_FOPID_GA = %5.5f\n',cons_u_major0_FOPID_GA);
fprintf(' cons_u_major0_FOPID_CE = %5.5f\n',cons_u_major0_FOPID_CE);
disp('--------------------------------------------------------')
disp('Constraint Quarantined:')
fprintf(' cons_quarantined_PID_GA = %5.5f\n',cons_quarantined_PID_GA);
fprintf(' cons_quarantined_PID_CE = %5.5f\n',cons_quarantined_PID_CE);
fprintf(' cons_quarantined_FOPID_GA = %5.5f\n',cons_quarantined_FOPID_GA);
fprintf(' cons_quarantined_FOPID_CE = %5.5f\n',cons_quarantined_FOPID_CE);
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