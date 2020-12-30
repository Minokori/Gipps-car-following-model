%% 画X-T轨迹散点图
clc;
%% 设置图窗
fig=figure( 'Name', 'x-t图' );
fig.WindowState='fullscreen';

%% 绘图
for i=1:N
    temp_t=2;
    for t=2:TIME-1
        if x_s( i, t+1 )<x_s( i, t )%避免出现杂线
            plot(temp_t:t , x_s( i, temp_t:t ), 'Color', [0.3,0.3,1]);
            temp_t=t+1;
            hold on;
        end
    end
    plot( temp_t:TIME, x_s( i, temp_t:TIME ), 'Color', [0.3,0.3,1]);%画出剩余轨迹
    hold on;
end

%% 标题及坐标轴
ylabel( '位置X 单位：米(m)' );
xlabel( '时间T 单位：秒(s)' );
title( 'X-T轨迹图' );
hold on;

%% 保存图片
print( 'X-T','-dpng', '-r300' );