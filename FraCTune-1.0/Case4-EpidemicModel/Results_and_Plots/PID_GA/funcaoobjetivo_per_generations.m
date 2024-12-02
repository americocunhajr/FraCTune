close all
clear all
clc

J = zeros(17,2);
X_param = zeros(17,4);
Ind = zeros(17,1);

J(:,1)=[1:1:17];
X_param(:,1)=[1:1:17];

load('gen_0000');
    
%J(1,2)=min(Score_gen);

[J(1,2),Ind(1)]=min(Score_gen);

X_param(1,2:4)=Population_gen(Ind(1),:);

for n = 1:9
 
load(sprintf(['gen_000', num2str(n)]));

[J(1+n,2),Ind(1+n)]=min(Score_gen);

X_param(1+n,2:4)=Population_gen(Ind(1+n),:);
    
%J(1+n,2)=min(Score_gen);

end

for n = 10:16

load(sprintf(['gen_00', num2str(n)]));
 
[J(1+n,2),Ind(1+n)]=min(Score_gen);

X_param(1+n,2:4)=Population_gen(Ind(1+n),:);

%J(1+n,2)=min(Score_gen);

end

%  for n = 100:103
%  
% load(sprintf(['gen_0', num2str(n)]));
%  
% [J(1+n,2),Ind(1+n)]=min(Score_gen);
% 
% X_param(1+n,2:6)=Population_gen(Ind(1+n),:);
% 
% %J(1+n,2)=min(Score_gen);
%  
%  end

J_GA_PID=J;
X_param_GA_PID=X_param;

save('GA_PID.mat','J_GA_PID','X_param_GA_PID')

figure(1)
plot(J(:,1),J(:,2),'o','linewidth',2)
%title('Minimum obj function per generation/iteration')
xlabel('Iterations/Generation');
ylabel('Minimum obj function');     

figure(2)
plot(X_param(:,2:4),'linewidth',2)
%title('Minimum obj function per generation/iteration')
xlabel('Iterations/Generation');
%ylabel('Minimum obj function'); 