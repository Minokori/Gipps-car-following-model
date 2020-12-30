function [x_next] = update_x( x, v, i, s )
%位置更新与检查函数
%输入 位置数组x，速度数组v，车辆编号i，仿真步数s，输出x( i, s )
global dt; global ring;
x_next=x( i, s-1)+v(i ,s-1 )*dt;
%位置检查
if x_next>=ring
   x_next=x_next-ring;
if x_next<=0
   x_next=x_next+ring;
end
end