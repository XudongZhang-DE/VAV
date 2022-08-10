%%%%%利用训练好的Q阵进行控制看看效果
clear all;
tic
%load trtQ Q;
load tr_randinitialQ2 Q;
p=1;
%%%%动作a初始化
load Q-action ac;
a11=1;a33=30;T=216;K=0.478;ke=1;te=2.5;b0=0.0022;b=0.0022;
wn=0.045;ii=0.95;h=0.1;gama=0.8;deta=0.1;%仿真步长+柔化系数
rfd1(2)=0;rfd2(2)=0;rfai(2)=0;z1(2)=0;z2(2)=0;z3(2)=0;I=0;
r(2)=0;dzr(2)=0;IAE(2)=0;
for j=2:1:9000
    %% ADRCu
    t(j)=h*j;
    rfr(j)=15*(sign(sin(2*pi/600*t(j)))+1);       %%%信号周期60s;
%     rfd1(j)=30*(sin(2*pi/600*t(j)));    %%%%正弦信号
    %% 滤波
    rfd1(j+1)=rfd1(j)+h*rfd2(j);%rfr(j);
    rfd2(j+1)=rfd2(j)+h*(-wn^2*rfd1(j)-2*ii*wn*rfd2(j)+wn^2*rfr(j));
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
    e(j)=rfai(j)-rfd1(j);de(j)=(e(j)-e(j-1))/h;
    c=state_select(e(j),de(j));
    %% 动作选择采用greedy策略
    Anext=find(Q(:,c)==max(Q(:,c)));
    if length(Anext)>1
        Anext_=unidrnd(length(Anext));
        Anext=Anext(Anext_);
    end
    AN=ac(Anext,:);
    trwo=AN(1);trkp=AN(2);trkd=AN(3);
    k1(j)=trwo;k2(j)=trkp;k3(j)=trkd;
    %sume=sume+e(j)^2;
    u0(j)=-trkp*e(j)+trkd*(-z2(j));
    u(j)=(u0(j)-z3(j))/b0;
    belta1=3*trwo;belta2=3*trwo^2;belta3=trwo^3;
%% LESO
    ee(j)=z1(j)-e(j); dy(j)=(rfai(j)-rfai(j-1))/h;
    z1(j+1)=z1(j)+h*(z2(j)-belta1*ee(j));
    z2(j+1)=z2(j)+h*(z3(j)-belta2*ee(j)+b0*u(j));
    z3(j+1)=z3(j)+h*(-belta3*ee(j));
%% 模型
    if dzr(j)>35   
       dzr(j)=35;
    end
    if dzr(j)<-35
        dzr(j)=-35;
    end
    rfai(j+1)=rfai(j)+h*r(j);
    r(j+1)=r(j)+h*(-a11/T*r(j)-a33/T*r(j)^3+b*dzr(j));%+w(j)
    dzr(j+1)=dzr(j)+h*(ke*(u(j)-dzr(j))/te);
    dzr_(j)=dzr(j);hui(j)=rfai(j);rfd_(j)=rfd1(j); 
    iae(j)=abs(hui(j)-rfd_(j));
    IAE(j)=IAE(j-1)+iae(j);
end
toc
figure
plot(t,IAE,'b','linewidth',1.5);
set(gca,'Fontname', 'Times New Roman');
xlabel('\fontname{Times New Roman}{\itt}(s)');
ylabel('IAE');
legend('Q-ADRC');
set(gcf,'position',[200,300,600,370.8]);
figure
     plot(t,rfd_,'r',t,hui,'--b','linewidth',1.5);
     legend('\psi_d','ADRC')
     legend('boxoff');
     title('Ship Course')
     figure
     hold on
     plot(t,k1,':k','linewidth',1.5)
     %legend('\omega_o');
     %figure
     plot(t,k2,'b','linewidth',1.5)
     %legend('k_p')
     %figure
     plot(t,k3,'r--','linewidth',1.5)
     legend('\omega_o','k_p','k_d')
     legend('boxoff');
     title('Parameters')
     hold off
     figure
plot(t,dzr_,'m','linewidth',1.5)
title('Rudder Angle')
legend('\delta')
legend('boxoff');