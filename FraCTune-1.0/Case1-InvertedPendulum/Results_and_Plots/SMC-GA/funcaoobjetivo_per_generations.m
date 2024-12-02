close all
clear all
clc

J = zeros(34,2);
X_param = zeros(34,3);
Ind = zeros(34,1);

J(:,1)=[1:1:34];
X_param(:,1)=[1:1:34];

load('gen_0000');
    
%J(1,2)=min(Score_gen);

[J(1,2),Ind(1)]=min(Score_gen);

X_param(1,2:3)=Population_gen(Ind(1),:);

for n = 1:9
 
load(sprintf(['gen_000', num2str(n)]));

[J(1+n,2),Ind(1+n)]=min(Score_gen);

X_param(1+n,2:3)=Population_gen(Ind(1+n),:);
    
%J(1+n,2)=min(Score_gen);

end

for n = 10:33

load(sprintf(['gen_00', num2str(n)]));
 
[J(1+n,2),Ind(1+n)]=min(Score_gen);

X_param(1+n,2:3)=Population_gen(Ind(1+n),:);

%J(1+n,2)=min(Score_gen);

end

%  for n = 100:104
%  
% load(sprintf(['gen_0', num2str(n)]));
%  
% [J(1+n,2),Ind(1+n)]=min(Score_gen);
% 
% X_param(1+n,2:3)=Population_gen(Ind(1+n),:);
% 
% %J(1+n,2)=min(Score_gen);
%  
%  end

J_GA_SMC=J;
X_param_GA_SMC=X_param;

save('GA_SMC.mat','J_GA_SMC','X_param_GA_SMC')

figure(1)
plot(J(:,1),J(:,2),'o','linewidth',2)
%title('Minimum obj function per generation/iteration')
xlabel('Iterations/Generation');
ylabel('Minimum obj function');     

figure(2)
plot(X_param(:,2:3),'linewidth',2)
%title('Minimum obj function per generation/iteration')
xlabel('Iterations/Generation');
%ylabel('Minimum obj function'); 