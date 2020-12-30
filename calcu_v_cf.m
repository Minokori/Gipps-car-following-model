function [v_cf] = calcu_v_cf( v_bk, v_fr, d)
%安全许可最大速度函数
%输入 t-as 的速度，前导车速度，距离，输出 t 的Gipps跟驰速度
global B; global act_time; global car_length;
v_cf=B*act_time+sqrt( B^2*act_time^2+B*( v_bk*act_time+v_fr^2/B+2*car_length-2*d ) );%Gipps跟驰速度
v_cf=real( v_cf );%若计算结果为虚数，求其实部
end

