close all
clear all
clc

num_gen=66;

J = zeros(num_gen,2);
X_param = zeros(num_gen,6);
Ind = zeros(num_gen,1);

J(:,1)=[1:1:num_gen];
X_param(:,1)=[1:1:num_gen];

load('gen_0000');
    
%if min(Score_gen)>0
    
    [J(1,2),Ind(1)]=min(Score_gen);
    
%else
%    [J(1,2),Ind(1)]=min(Score_gen*0);
%end
X_param(1,2:6)=Population_gen(Ind(1),:);


for n = 1:9
 
load(sprintf(['gen_000', num2str(n)]));


%if min(Score_gen)>0
    
    [J(1+n,2),Ind(1+n)]= min(Score_gen);
    
%else
%    [J(1+n,2),Ind(1+n)]= min(Score_gen*0);
%end
X_param(1+n,2:6)=Population_gen(Ind(1+n),:);
    
%J(1+n,2)=min(Score_gen);

end

for n = 10:num_gen-1

load(sprintf(['gen_00', num2str(n)]));
 
%if min(Score_gen)>0
    
    [J(1+n,2),Ind(1+n)]= min(Score_gen);
    
%else
%    [J(1+n,2),Ind(1+n)]= min(Score_gen*0);
%end
X_param(1+n,2:6)=Population_gen(Ind(1+n),:);
%J(1+n,2)=min(Score_gen);

end

%  for n = 100:103
%  
% load(sprintf(['gen_0', num2str(n)]));
%  
% [J(1+n,2),Ind(1+n)]=min(Score_gen(Score_gen>0));
% 
% X_param(1+n,2:6)=Population_gen(Ind(1+n),:);
% 
% %J(1+n,2)=min(Score_gen);
%  
%  end

J_GA_FOSMC=J;
X_param_GA_FOSMC=X_param;

save('GA_FOSMC.mat','J_GA_FOSMC','X_param_GA_FOSMC')

figure(1)
plot(J(:,1),J(:,2),'o','linewidth',2)
%title('Minimum obj function per generation/iteration')
xlabel('Iterations/Generation');
ylabel('Minimum obj function');     
%ylim([-1 0])

figure(2)
plot(X_param(:,2:6),'linewidth',2)
%title('Minimum obj function per generation/iteration')
xlabel('Iterations/Generation');
%ylabel('Minimum obj function'); 