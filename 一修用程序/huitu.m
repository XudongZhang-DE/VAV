%% 绘制正弦扰动下的船舶航向曲线图
load Q-courese-sin-disturbance yh2;
 Q_y=yh2;
 load L-courese-sin-disturbance yh2;
 L_y=yh2;
load set-course yh1;
set_y=yh1;
load time xh1;
t=xh1;
figure
plot(t,set_y,'k','linewidth',1.5)
hold on
plot(t,Q_y,'r--','linewidth',1.5)
hold on 
plot(t,L_y,':b','linewidth',1.5)
hold on 
legend('\psi_{\itd}','QADRC','LADRC')
 legend('boxoff');title('Ship Course sin')
 xlabel('{\itt}/s');ylabel('\psi(deg)')
 hold off
 %% 绘制无扰动下的船舶航向曲线图
 load Q-course yh2;
 Q_y=yh2;
 load L-course yh2;
 L_y=yh2;
load set-course yh1;
set_y=yh1;
load time xh1;
t=xh1;
figure
plot(t,set_y,'k','linewidth',1.5)
hold on
plot(t,Q_y,'r--','linewidth',1.5)
hold on 
plot(t,L_y,':b','linewidth',1.5)
hold on 
legend('\psi_{\itd}','QADRC','LADRC')
 legend('boxoff');title('Ship Course wu')
 xlabel('{\itt}/s');ylabel('\psi(deg)')
 hold off
 %% 绘制恒值扰动下的船舶航向曲线图
  load Q-course-constant yh2;
 Q_y=yh2;
 load L-course-constant yh2;
 L_y=yh2;
load set-course yh1;
set_y=yh1;
load time xh1;
t=xh1;
figure
plot(t,set_y,'k','linewidth',1.5)
hold on
plot(t,Q_y,'r--','linewidth',1.5)
hold on 
plot(t,L_y,':b','linewidth',1.5)
hold on 
legend('\psi_{\itd}','QADRC','LADRC')
 legend('boxoff');title('Ship Course constant')
 xlabel('{\itt}/s');ylabel('\psi(deg)')
 hold off
 %% 绘制白噪声下的船舶航向曲线图
 load Q-course-white yh2;
 Q_y=yh2;
 load L-course-white yh2;
 L_y=yh2;
load set-course yh1;
set_y=yh1;
load time xh1;
t=xh1;
figure
plot(t,set_y,'k','linewidth',1.5)
hold on
plot(t,Q_y,'r--','linewidth',1.5)
hold on 
plot(t,L_y,':b','linewidth',1.5)
hold on 
legend('\psi_{\itd}','QADRC','LADRC')
 legend('boxoff');title('Ship Course white')
 xlabel('{\itt}/s');ylabel('\psi(deg)')
 hold off