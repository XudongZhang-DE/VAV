%%%�������ѡ�����_2019/11/29ע��
function y = soft_a(Q,s,q)
y=fix(999*rand(1))+1;

while (Q(y,s))==q
y=fix(1000*rand(1))+1;
end

end

