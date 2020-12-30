function [v_next] = update_v( v, a, i, s )
%速度更新与检查函数
%输入 速度数组v，加速度数组a，车辆编号i，仿真步数s，输出v( i, s )
global dt; 
v_next=v( i, s-1)+a( i, s-1)*dt;
if v_next<=0
    v_next=0;
end
end

