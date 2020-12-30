%% ��K-Vɢ��ͼ
clc;

%% ����ͼ��
fig=figure('name','K-V����ͼ');
fig.WindowState='fullscreen';

%% ���۲⳵��K-Vɢ��ͼ
scatter(v_s,k_s,10,[0.3,0.3,1],'filled');
hold on;

%% ���۲⳵��K-Vƽ��ֵ
scatter(avg_v,avg_k,50,'red','d','filled');
hold on;
avg_plot=strcat('�۲⳵ƽ��ֵ���꣺','(',num2str(roundn(avg_v,-2)),',',num2str(roundn(avg_k,-2)),')');
text1=text(avg_v,avg_k+5,avg_plot);
text1.FontSize=15;
text1.Color='b';
hold on;

%% ���۲⳵��K-V�����
plot(dv_fit_v,dv_fit_k,'Color','red','DisplayName','�������');
fit_plot=strcat('������ߣ�','K=(',num2str(dv_p(1)),'V^2+',num2str(dv_p(2)),'V+',num2str(dv_p(3)),')^-^1');
text2=text(avg_v,avg_k+15,fit_plot);
text2.FontSize=15;
text2.Color='b';
hold on;

%% �����ߵ�K-V��
scatter(all_v,all_k,50,'y','d','filled');
all_plot=strcat('����ƽ��ֵ���꣺','(',num2str(roundn(all_v,-2)),',',num2str(roundn(all_k,-2)),')');
text3=text(avg_v,avg_k+10,all_plot);
text3.FontSize=15;
text3.Color='b';
hold on;

%% ��Gipps����K-V��
plot(exp_v,exp_k,'Color','m','LineStyle','--');
ex_plot=strcat('Gipps�������ߣ�','K=',num2str(3*act_time/3600/2),'V+',num2str(car_length/1000),')^-^1');
text4=text(avg_v,avg_k+20,ex_plot);
text4.FontSize=15;
text4.Color='b';
hold on;

%% ͼ��
legend(' ',' ','�������',' ','��������');

%% ���⼰������
xlabel('�ٶ�V ��λ��km/h');
ylabel('�ܶ�K ��λ��veh/km');
title('K-V����ͼ');

%% ����ͼ��
print('K-V','-dpng','-r300');