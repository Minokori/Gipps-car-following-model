function [v_ff] = calcu_v_ff( v_before_act )
%自由加速状态速度函数
%输入 t-as 的速度，输出 t 的自由加速状态速度
global A; global act_time; global v_f; 
v_ff=v_before_act+2.5*A*act_time*( 1-v_before_act/v_f )*sqrt( 0.025+v_before_act/v_f );%Gipps自由流速度
end