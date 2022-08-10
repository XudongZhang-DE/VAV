function y=f(m,n)
k=fix(5*rand(m,n))+1;
for i=1:m*n
if (k(i))==4
k(i)=k(i)+1;
end
end
k