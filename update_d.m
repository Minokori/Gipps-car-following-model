function [d_next] = update_d( x, i, s)
%距离计算函数
%输入 位置数组x，车辆编号i，仿真步数s，输出d( i, s )
global ring;  global N;
%% 设置前导车和跟驰车
if i==1
    num_bk=1; num_fr=N;
else
    num_bk=i; num_fr=i-1;
end
%% 距离更新
if ( x( num_bk, s )==max( x( :, s ) ) ) && ( x( num_fr, s )==min( x( :, s ) ) )%判断前导车和跟驰车是否跨起点
    d_next=x( num_fr, s )-x( num_bk, s )+ring;%距离修正
else
    d_next=x( num_fr, s )-x( num_bk, s );
end

end