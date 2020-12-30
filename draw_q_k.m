%% 画Q-K散点图
clc;

%% 设置图窗
fig=figure( 'name', 'K-Q基本图');
fig.WindowState='fullscreen';

%% 画观测车的Q-K散点图
scatter(k_s,q_s,10,[0.3,0.3,1],'filled');
hold on;

%% 画观测车的Q-K平均值
scatter(avg_k,avg_q,50,'red','d','filled');
hold on;
avg_plot=strcat('观测车平均值坐标：','(',num2str(roundn(avg_k,-2)),',',num2str(roundn(avg_q,-2)),')');
text1=text(avg_k,avg_q+200,avg_plot);
text1.FontSize=15;
text1.Color='b';
hold on;

%% 画观测车的Q-K拟合线
line(qk_fit_k,qk_fit_q,'Color','red');
fit_line=strcat('拟合曲线：','Q=',num2str(roundn(qk_p(1),-2)),'K+',num2str(roundn(qk_p(2),-2)));
text2=text(avg_k,avg_q+600,fit_line);
text2.FontSize=15;
text2.Color='b';

%% 画环线的Q-K点
scatter(all_k,all_q,50,'y','d','filled');
all_plot=strcat('环线平均值坐标：','(',num2str(roundn(all_k,-2)),',',num2str(roundn(all_q,-2)),')');
text3=text(avg_k,avg_q+400,all_plot);
text3.FontSize=15;
text3.Color='b';
hold on;

%% 标题及坐标轴
xlabel('密度K 单位：辆/km');
ylabel('流量Q 单位：辆/h');
title('Q-K基本图');

%% 保存图像
print('Q-K','-dpng','-r300');