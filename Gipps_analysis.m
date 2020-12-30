%% 数据分析
clear;clc;

%% 导入数据
load Gipps.mat;

%% 画X-T图准备工作
%每秒取值
x_s=zeros( N, TIME );
for i=1:N
    for t=1:TIME
        x_s( i, t )=x( i, t*10 );
    end
end

%% 画最大距离图准备工作

%求最大车距
d_max=zeros( 1, STEP );
for t=1:STEP
    d_max( t )=max( d( :, t ) );
end

%每秒取值
d_max_s=zeros( 1, TIME );
for t=1:TIME
    d_max_s( 1, t )=d_max( 1, t*10 );
end

%% 画Q-K-V图准备工作

%画观测车的数据
% 计算基本参数q，k，v
s=zeros( 1, STEP );
qkv_d=zeros( 1, STEP );
qkv_k=zeros( 1, STEP );
qkv_q=zeros( 1, STEP );
% 按秒取值
for t=1:STEP
    qkv_d( 1, t )=d(N,t)/1000;%车距，单位：km //距离d只是用来求k的中间变量
    qkv_k( 1, t )=1/( qkv_d( 1, t ) );%车距的倒数作为密度，单位：veh/km
    qkv_q( 1, t )=qkv_k( 1, t )*( v( N, t )*3.6 );%流量，单位：veh/h
end
qkv_v=v( N, : )*3.6;%速度，单位km/h

%将k，v，q放在一个矩阵中
k_v_q=zeros( STEP, 3 );
k_v_q( :, 1 )=qkv_k;
k_v_q( :, 2 )=qkv_v;
k_v_q( :, 3 )=qkv_q;

%每秒取值
q_s=zeros( 1, TIME );
k_s=zeros( 1, TIME );
for i=1:N
    for t=1:TIME
        q_s( 1, t )=k_v_q( t*10, 3 );
        k_s( 1, t )=k_v_q( t*10, 1 );
        v_s( 1, t )=k_v_q( t*10, 2 );
    end
end

%求平均值
avg_k=sum( k_s )/TIME;
avg_q=sum( q_s )/TIME;
avg_v=sum( v_s )/TIME;

%求Q-K拟合直线
qk_p = polyfit( qkv_k, qkv_q, 1 );%Q-K曲线用直线拟合
qk_fit_k=[min( k_s ),max( k_s ) ];%计算拟合曲线
qk_fit_q=qk_p( 1 )*qk_fit_k+qk_p( 2 );

%求K-V拟合曲线
dv_p = polyfit( qkv_v, qkv_d, 2 );%K-V曲线用距离D做中间值二项式拟合
dv_fit_v=min( v_s ):max( v_s );%计算拟合曲线
dv_fit_d=dv_p( 1 )*dv_fit_v.^2+dv_p( 2 )*dv_fit_v+dv_p( 3 );
dv_fit_k=1./dv_fit_d;%由D-V曲线求出K-V曲线

%求V-Q拟合曲线
vq_p = polyfit( qkv_q, qkv_v, 2 );%V-Q曲线用二项式拟合
vq_fit_q=min( q_s ):max( q_s );%计算拟合曲线
vq_fit_v=vq_p( 1 )*vq_fit_q.^2+vq_p( 2 )*vq_fit_q+vq_p( 3 );

%求期望K-V关系曲线
exp_v=0:max( v_s );
exp_s=( 3*act_time/3600/2 ).*exp_v+car_length/1000;%由微观到宏观单位转化
exp_k=1./( exp_s );%计算拟合曲线

% 画整个环线的Q-K-V点
all_k=N/( ring/1000 );
all_v=mean( v, 'all' )*3.6;
all_q=all_k*all_v;
%% 保存数据
save Gipps_analysis.mat;

