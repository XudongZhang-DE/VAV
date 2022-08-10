%%%%%动作组合初始化
clear all;
p=1;
for k=1:10
    wo(k)=0.3+(k-1)*(1.5-0.3)/9;
    kp(k)=(k-1)*(0.015-0)/9;
    kd(k)=0.05+(k-1)*(0.5-0.05)/9;
end
for k=1:10
    for j=1:10
        for i=1:10
            ac(p,:)=[wo(k) kp(j) kd(i)];
            p=p+1;
        end
    end
end
save Q-action ac;