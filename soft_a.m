%%%随机动作选择程序_2019/11/29注释
function y = soft_a(Q,s,q)
y=fix(999*rand(1))+1;

while (Q(y,s))==q
y=fix(1000*rand(1))+1;
end

end

