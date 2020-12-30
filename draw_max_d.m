%% 画最大车距图
clc;

%% 设置图窗
fig=figure('Name','最大车距图');
fig.WindowState='fullscreen';

%% 绘图
scatter(1:TIME,d_max_s,4);

%% 标题及坐标轴
ylabel('最大车头间距D 单位：米(m)');
xlabel('时间T 单位：秒(s)');
title('最大车头间距');
hold on;

%% 保存图片
print('D_max','-dpng','-r300');