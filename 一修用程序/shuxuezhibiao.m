clear all;
%% 无扰动情况
load Q-course yh2;
 Q_y=yh2;
 load L-course yh2;
 L_y=yh2;
load set-course yh1;
set_y=yh1;
load time xh1;
t=xh1;
Qe_y=Q_y-set_y;
% aQe_y=abs(Qe_y);
% Qs=sum(aQe_y(:));%IAE指标Q-learning
% Qsum=dot(aQe_y,t);%ITAE指标Q-learning
Le_y=L_y-set_y;
% aLe_y=abs(Le_y);
% Ls=sum(aLe_y(:));%IAE指标LADRC
% Lsum=dot(aLe_y,t);%ITAE指标LADRC
% x=0.1:0.1:10;
% for k=1:100
%  y1(k)=Lsum; 
%  y2(k)=Qsum;
% end
% figure
% plot(x,y1,x,y2)
% legend('LADRC','QADRC')
figure
plot(t,Le_y,t,Qe_y,'--','linewidth',1.5)
set(gca,'fontname','Times New Roman','FontSize', 9)
legend('LADRC','Q\_ADRC')
legend('boxoff');title('Tracking Error','fontname','Times New Roman','FontSize',9)
xlabel('{\itt}/s');ylabel('\psi(deg)')
%% 恒值扰动
load Q-course-constant yh2;
 Q_y=yh2;
 load L-course-constant yh2;
 L_y=yh2;
load set-course yh1;
set_y=yh1;
load time xh1;
t=xh1;
Qe_y=Q_y-set_y;
Le_y=L_y-set_y;
figure
plot(t,Le_y,t,Qe_y,'--','linewidth',1.5)
set(gca,'fontname','Times New Roman','FontSize', 9)
legend('LADRC','Q\_ADRC')
legend('boxoff');title('Tracking Error','fontname','Times New Roman','FontSize',9')
xlabel('{\itt}/s');ylabel('\psi(deg)')
%% 正弦扰动
load Q-courese-sin-disturbance yh2;
 Q_y=yh2;
 load L-courese-sin-disturbance yh2;
 L_y=yh2;
load set-course yh1;
set_y=yh1;
load time xh1;
t=xh1;
Qe_y=Q_y-set_y;
Le_y=L_y-set_y;
figure
plot(t,Le_y,t,Qe_y,'--','linewidth',1.5)
set(gca,'fontname','Times New Roman','FontSize', 9)
legend('LADRC','Q\_ADRC')
legend('boxoff');title('Tracking Error','fontname','Times New Roman','FontSize',9)
xlabel('{\itt}/s');ylabel('\psi(deg)')
%% 白噪声扰动
load Q-course-white yh2;
 Q_y=yh2;
 load L-course-white yh2;
 L_y=yh2;
load set-course yh1;
set_y=yh1;
load time xh1;
t=xh1;
Qe_y=Q_y-set_y;
Le_y=L_y-set_y;
figure
plot(t,Le_y,t,Qe_y,'--','linewidth',1.5)
set(gca,'fontname','Times New Roman','FontSize', 9)
legend('LADRC','Q\_ADRC')
legend('boxoff');title('Tracking Error','fontname','Times New Roman','FontSize',9)
xlabel('{\itt}/s');ylabel('\psi(deg)')