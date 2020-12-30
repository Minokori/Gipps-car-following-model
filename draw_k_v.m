%% 画K-V散点图
clc;

%% 设置图窗
fig=figure('name','K-V基本图');
fig.WindowState='fullscreen';

%% 画观测车的K-V散点图
scatter(v_s,k_s,10,[0.3,0.3,1],'filled');
hold on;

%% 画观测车的K-V平均值
scatter(avg_v,avg_k,50,'red','d','filled');
hold on;
avg_plot=strcat('观测车平均值坐标：','(',num2str(roundn(avg_v,-2)),',',num2str(roundn(avg_k,-2)),')');
text1=text(avg_v,avg_k+5,avg_plot);
text1.FontSize=15;
text1.Color='b';
hold on;

%% 画观测车的K-V拟合线
plot(dv_fit_v,dv_fit_k,'Color','red','DisplayName','拟合曲线');
fit_plot=strcat('拟合曲线：','K=(',num2str(dv_p(1)),'V^2+',num2str(dv_p(2)),'V+',num2str(dv_p(3)),')^-^1');
text2=text(avg_v,avg_k+15,fit_plot);
text2.FontSize=15;
text2.Color='b';
hold on;

%% 画环线的K-V点
scatter(all_v,all_k,50,'y','d','filled');
all_plot=strcat('环线平均值坐标：','(',num2str(roundn(all_v,-2)),',',num2str(roundn(all_k,-2)),')');
text3=text(avg_v,avg_k+10,all_plot);
text3.FontSize=15;
text3.Color='b';
hold on;

%% 画Gipps理论K-V线
plot(exp_v,exp_k,'Color','m','LineStyle','--');
ex_plot=strcat('Gipps理论曲线：','K=',num2str(3*act_time/3600/2),'V+',num2str(car_length/1000),')^-^1');
text4=text(avg_v,avg_k+20,ex_plot);
text4.FontSize=15;
text4.Color='b';
hold on;

%% 图例
legend(' ',' ','拟合曲线',' ','理论曲线');

%% 标题及坐标轴
xlabel('速度V 单位：km/h');
ylabel('密度K 单位：veh/km');
title('K-V基本图');

%% 保存图像
print('K-V','-dpng','-r300');