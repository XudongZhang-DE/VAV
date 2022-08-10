%%%%%%%%%%%%随机初始化状态 动作选择采用s-greedy策略 0505
%%%%%%%%%%%%状态的随机初始化非等概率，假使1-7/43-49为0.3；其他状态出现为0.7
clear all;
tic
p=1;
%%%%动作a初始化
load Q-action ac;
%load tr_randinitialQ2 Q;
Q=zeros(1000,49);
for k=1:10000
    sc=1;
    select_index=rand(1);kk=unidrnd(1000);
    if select_index<0.7
    %initial_Q=Q(m,n);
        kde=unidrnd(49);
    else
        kde=unidrnd(35)+7;
    end
    initial_Q=Q(kk,kde);
    num=rand(1);n=kde;
    Anext=find(Q(:,kde)==max(Q(:,kde)));
    len=length(Anext);
    if len>1
        Anext_=unidrnd(length(Anext));
        Anext=Anext(Anext_);
    end
    amax=Anext;
    if num<0.8
        Anext=amax;
    else if len~=1000
        Anext=soft_a(Q,n,Q(amax,n));
        else
            Anext=round(rand(1,1)*999+1);
        end
        %round(rand(1,1)*999+1);
    end
    initial_A=ac(Anext,:);m=Anext;
    trwo=initial_A(1);trkp=initial_A(2);trkd=initial_A(3);
    [e(2),de(2)]=initial_error(n);
    flag=1;sume=0;%train
    a11=1;a33=30;T=216;K=0.478;ke=1;te=2.5;b0=0.0022;b=0.0022;
    wn=0.045;ii=0.95;h=0.1;gama=0.8;deta=0.1;%仿真步长+柔化系数
    rfd1(2)=0;rfd2(2)=0;rfai(2)=e(2);z1(2)=0;z2(2)=de(2);z3(2)=0;I=0;
    r(2)=0;dzr(2)=0;
    for j=2:1:9000
    %% ADRCu
    t(j)=h*j;
    rfr(j)=15*(sign(sin(2*pi/6000*t(j)))+1);       %%%信号周期60s;
    %% 滤波
    rfd1(j+1)=rfd1(j)+h*rfd2(j);
    rfd2(j+1)=rfd2(j)+h*(-wn^2*rfd1(j)-2*ii*wn*rfd2(j)+wn^2*rfr(j));
    w(j)=0.00*rand(1);
    belta1=3*trwo;belta2=3*trwo^2;belta3=trwo^3;
    e(j)=rfai(j)-rfd1(j);sume=sume+e(j)^2;
    u0(j)=-trkp*e(j)+trkd*(-z2(j));
    u(j)=(u0(j)-z3(j))/b0;
    
%% LESO
    ee(j)=z1(j)-e(j);dy(j)=(rfai(j)-rfai(j-1))/h;
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
    r(j+1)=r(j)+h*(-a11/T*r(j)-a33/T*r(j)^3+w(j)+b*dzr(j));
    dzr(j+1)=dzr(j)+h*(ke*(u(j)-dzr(j))/te);
    if mod(j,100)==0
        flag=0;
    end
%% 判断当前状态s，确定在该状态下要采用的参数。
    p=j+1;
    e(p)=rfai(p)-rfd1(p);
    de(p)=(e(p)-e(p-1))/h;
    ae=abs(e(j));
    if flag==0
        if sume/10>0.0001
            reward=-100;
        else
            reward=100;
        end
        %%%%s域初始化
        c=state_select(e(p),de(p));
         x1=find(Q(:,c)==max(Q(:,c))); %%% 寻找最大值
         if length(x1)>1
            x1_=unidrnd(length(x1));
            x1=x1(x1_);
         end
        mQ=Q(x1,c);
        Q(m,n)=Q(m,n)+deta*(reward+gama*mQ-Q(m,n));
         num=rand(1);
         Anext=find(Q(:,c)==max(Q(:,c)));
         len=length(Anext);
        if len>1
            Anext_=unidrnd(length(Anext));
            Anext=Anext(Anext_);
        end
        amax=Anext;
        if num<0.8
            Anext=amax;
        else if len~=1000
                Anext=soft_a(Q,n,Q(amax,n));
            else
                Anext=round(rand(1,1)*999+1);
            end
        end
%     if num<0.7
%         Anext=find(Q(:,c)==max(Q(:,c)));
%         if length(Anext)>1
%             Anext_=unidrnd(length(Anext));
%             Anext=Anext(Anext_);
%         end
%     else 
%         Anext=round(rand(1,1)*999+1);
%     end
    cue(sc)=sume;
        AN=ac(Anext,:);
        trwo=AN(1);trkp=AN(2);trkd=AN(3);    
        m=Anext;n=c;sume=0;
        flag=1;sc=sc+1;
    end
    %%选择下一步动作
    dzr_(j)=dzr(j);hui(j)=rfai(j);rfd_(j)=rfd1(j); k1(j)=trwo;k2(j)=trkp;k3(j)=trkd;   
    %%%一次MDP终止条件_0419新增e(j)作为终止条件
    if (((j>20)&&((abs(de(j))<=0.01)&&(abs(e(j))<=0.001)&&(hui(j))>28))||(abs(e(j))>25))
        break;
    end
    I=I+ae*t(j);
    end
%     plot(t,hui);
%     hold on;
    ITAE(k)=I;
end
toc
save much_tr_randinitialQ2 Q;
% plot(t,rfd_);
% legend('ADRC','fai_d')
% figure
% p=1:5000;
% plot(p,ITAE)