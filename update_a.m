function [a_next] = update_a( v_next , v )
%加速度更新与检查函数
%输入中间变量v_next，t  的速度v，输出 t 的加速度
global v_f; global A; global B; global dt;
 v_next=min( v_next, v_f );%速度不超过要求速度
 v_next=max( v_next, 0 );%刹车导致停车时速度不小于0
 a_next=( v_next-v )/dt;
 a_next=min( a_next, A );%加速度不大于最大加速度
 a_next=max( a_next, B );%加速度不小于最小加速度
end