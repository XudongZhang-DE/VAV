%%%根据实际时刻的误差状态判断当前状态属于哪个状态值。

function [state] = state_select(a,b)
%状态选择子函数
%隶属-状态码
%% e
%NB-(-3)
if a<=-5%%a>-30&&
    a_num=-3;
end
%NM-(-2)
if a>-5&&a<=-2
    a_num=-2;
end
%NS-(-1)
if a>-2&&a<=-0.5
    a_num=-1;
end
%Z-0
if a>-0.5&&a<0.5
    a_num=0;
end
%PS-1
if a>=0.5&&a<2
    a_num=1;
end
%PM-2
if a>=2&&a<5
    a_num=2;
end
%PB-3
if a>=5%%&&a<30
    a_num=3;
end
%% de
%NB-(-3)
if b<=-15
    b_num=-3;end
%NM-(-2)
if b>-15&&b<=-5
    b_num=-2;end
%NS-(-1)
if b>-5&&b<=-1
    b_num=-1;end
%Z-0
if b>-1&&b<1
    b_num=0;end
%PS-1
if b>=1&&b<5
    b_num=1;end
%PM-2
if b>=5&&b<15
    b_num=2;end
%PB-3
if b>=15
    b_num=3;end
sc=[-3,-2,-1,0,1,2,3];
s=1;
%% 状态选择
for i=1:7
    for j=1:7
        if a_num==sc(i)&&b_num==sc(j)
            state=s;
        end
        s=s+1;
    end
end
end

