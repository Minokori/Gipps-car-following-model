%% 设置Gipps基本参数
%设置初始参数，并保存
clear;
clc;
%% 车辆数据 
global car_length; car_length=6;%车辆长度，m
global v_f; v_f=30/3.6;%期望速度，m/s
global A; A=4;%最大加速度，m/s^2
global B; B=-6;%最大减速度，m/s^2
%% 驾驶员数据
%
global act_time; act_time=1;%反应时间，s
react_speed=40/3.6;%应激速度
%% 实验场景数据
%

global ring; ring=230;%环线长度，m
TIME=1000;%实验时间，s，亦为最大时间
global dt; dt=0.1;%仿真步长，即每0.1s进行一次迭代
STEP=floor( TIME/dt );%实验总步长，亦为最大步数 //floor为向下取整
step=1:STEP;%步轴
global N; N=22;%车辆数，亦为车辆最大编号
n=1:N;%将车辆编号为1-10

%慢化相关参数
p_bottle=0.4;%瓶颈车慢化概率
%% 设置初始状态
%
%设置位置矩阵
x=zeros( N, STEP );
%第1辆车的初始位置最大，第N辆车在原点
for i=1:N
    x(i,1)=ring-i*ring/N;%等距设置车辆初始位置
end
%初始车距合理性检测
if ( ring/N<=car_length )
    fprintf("初始车距小于车辆长度");
end

%设置速度矩阵
v=zeros( N, STEP );
for i=1:N
    v( i, 1 )=v_f+randn;%初始速度，并考虑不完美的驾驶操控行为 //驾驶速度在期望速度[-1,1]区间内随机分布
end

%设置初始加速度矩阵
a=zeros( N, STEP );
for i=1:N
    a( i, 1 )=randn;%设计机初始加速度 //加速度在[-1,1]之间随机分布
end
%% 清除临时变量
%
clear i;
%% 保存数据
%保存当前工作空间
save Gipps_start.mat;