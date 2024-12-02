close all; clear all; clc;

%% --------------- Irregular road profile ---------------------
n0   = 0.1;
k    = 3;
L    = 100;
dn   = 1/L;
nmax = 2;
N    = nmax/dn;
xe   = (0:N-1)*L/N;
h    = zeros(1,N);
fi   = 2*pi*rand(1,N);

for i = 1:N
    h = h+sqrt(dn)*(2^k)*0.001*n0/(i*dn)*cos(2*pi*i*dn*xe+fi(i));
end

hi = h';

desl = xe;

save h.mat

figure(1)
plot(desl, h, '-k','linewidth',2,'DisplayName','Road Profile'); 
xlabel('Road distance [meters]','FontSize', 12);
ylabel('Height Irregularity [meters]','FontSize', 12);
legend('Location','best','FontSize', 12);
