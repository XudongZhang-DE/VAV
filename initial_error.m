function [ine,inde] = initial_error(st)
%%%%%随机初始化实现
%% e
pe(1)=25*rand(1)-30;pe(2)=3*rand(1)-5;pe(3)=1.5*rand(1)-2;
pe(4)=rand(1)-0.5;pe(5)=1.5*rand(1)+0.5;pe(6)=3*rand(1)+2;
pe(7)=25*rand(1)+5;
%% de
pde(1)=35*rand(1)-15;pde(2)=10*rand(1)-15;pde(3)=4*rand(1)-5;
pde(4)=2*rand(1)-1;pde(5)=4*rand(1)+1;pde(6)=10*rand(1)+5;
pde(7)=35*rand(1)+15;
ct=1;
for i=1:7
    for j=1:7
        ss(ct,:)=[pe(i) pde(j)];
        ct=ct+1;
    end
end
ine=ss(st,1);inde=ss(st,2);
end

