%% 画V-Q散点图
clc;
%% 设置图窗
fig=figure( 'name', 'V-K基本图' );
fig.WindowState='fullscreen';

%% 画观测车的V-Q散点图
scatter( q_s, v_s, 10, [0.3,0.3,1], 'filled' );
hold on;

%% 画观测车的V-Q平均值
scatter( avg_q, avg_v, 50, 'red', 'd', 'filled' );
hold on;
avg_plot=strcat( '观测车平均值坐标：', '(', num2str(roundn(avg_k,-2)), ',', num2str(roundn( avg_v, -2 ) ), ')' );
text1=text( avg_q, avg_v+15, avg_plot );
text1.FontSize=15;
text1.Color='b';
hold on;

%% 画观测车的V-Q拟合线
plot( vq_fit_q,vq_fit_v, 'Color','red' );
fit_plot=strcat( '拟合曲线：', 'V=', num2str( vq_p( 1 ) ), 'Q^2+', num2str( vq_p( 2 ) ), 'Q', num2str( vq_p ( 3 ) ) );
text2=text( avg_q, avg_v+25, fit_plot );
text2.FontSize=15;
text2.Color='b';
hold on;

%% 画环线的V-Q点
scatter( all_q, all_v,50, 'y','d', 'filled' );
all_plot=strcat( '环线平均值坐标：', '(', num2str( roundn( all_q, -2 ) ), ',', num2str( roundn( all_v ,-2 ) ), ')' );
text3=text( avg_q, avg_v+20, all_plot );
text3.FontSize=15;
text3.Color='b';
hold on;

%% 标题及坐标轴
xlabel( '流量Q 单位：veh/h' );
ylabel( '速度V 单位：km/h' );
title( 'V-Q基本图' );

%% 保存图像
print( 'V-Q', '-dpng', '-r300' );