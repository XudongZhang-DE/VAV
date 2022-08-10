%%%第三篇Q学习对比用LADRC
clear all;
h=0.1;a11=1;a33=30;T=216;K=0.478;ke=1;te=2.5;b0=0.0022;b=K/T;wn=0.045;ii=0.95;
r(2)=0;rfai(2)=0;rfd1(2)=0;rfd2(2)=0;z1(2)=0;z2(2)=0;z3(2)=0;dzr(2)=0;%T=216;K=0.478;
wo=0.7;belta1=3*wo;belta2=3*wo^2;belta3=wo^3;e(2)=0;wc=0.04;kp=wc^2;kd=2*wc;
wo=0.8333;kp=0.01167;kd=0.25;
for j=2:1:9000
    %% ADRCu
    t(j)=h*j;
     rfr(j)=15*(sign(sin(2*pi/600*t(j)))+1);       %%%信号周期60s; 
      rfr(j)=15*(sign(sin(2*pi/600*t(j)))+1);    
%    rfd1(j)=30*(sin(2*pi/600*t(j)));    %%%%正弦信号
    %% 滤波
 rfd1(j+1)=rfd1(j)+h*rfd2(j);
rfd2(j+1)=rfd2(j)+h*(-wn^2*rfd1(j)-2*ii*wn*rfd2(j)+wn^2*rfr(j));   
%     rfd1(j+1)=rfd1(j)+h*rfd2(j);%rfr(j);
%     rfd2(j+1)=rfd2(j)+h*(-wn^2*rfd1(j)-2*ii*wn*rfd2(j)+wn^2*rfr(j));
%     w(j)=15*b*rand(1);
%     if j>2000
%         w(j)=7*b;
%      else
%         w(j)=0;
%     end
%     if j>2000
%         w(j)=4*K/T*sin(0.1*(t(j)));
%     else
%         w(j)=0;
%     end
    e(j)=rfai(j)-rfd1(j);
    u0(j)=-kp*e(j)+kd*(-z2(j));
    u(j)=(u0(j)-z3(j))/b0;
%% LESO
    ee(j)=z1(j)-e(j); 
    z1(j+1)=z1(j)+h*(z2(j)-belta1*ee(j));
    z2(j+1)=z2(j)+h*(z3(j)-belta2*ee(j)+b0*u(j));
    z3(j+1)=z3(j)+h*(-belta3*ee(j));
%% 模型
    if dzr(j)>35;   
       dzr(j)=35;
    end
    if dzr(j)<-35;
        dzr(j)=-35;
    end
    rfai(j+1)=rfai(j)+h*r(j);
    r(j+1)=r(j)+h*(-a11/T*r(j)-a33/T*r(j)^3+b*dzr(j));%+w(j)
    dzr(j+1)=dzr(j)+h*(ke*(u(j)-dzr(j))/te);
    dzr_(j)=dzr(j);hui(j)=rfai(j);rfd_(j)=rfd1(j); 
end
figure
plot(t,rfd_,'r',t,hui,'--b','linewidth',1.5);
legend('\psi_d','LADRC')
legend('boxoff');
title('Ship Course')
%%%%%观察下控制量的抖振对比情况
figure
plot(t,dzr_,'m','linewidth',1.5)
legend('\delta')
legend('boxoff');
title('Rudder Angle')