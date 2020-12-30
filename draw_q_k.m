%% ��Q-Kɢ��ͼ
clc;

%% ����ͼ��
fig=figure( 'name', 'K-Q����ͼ');
fig.WindowState='fullscreen';

%% ���۲⳵��Q-Kɢ��ͼ
scatter(k_s,q_s,10,[0.3,0.3,1],'filled');
hold on;

%% ���۲⳵��Q-Kƽ��ֵ
scatter(avg_k,avg_q,50,'red','d','filled');
hold on;
avg_plot=strcat('�۲⳵ƽ��ֵ���꣺','(',num2str(roundn(avg_k,-2)),',',num2str(roundn(avg_q,-2)),')');
text1=text(avg_k,avg_q+200,avg_plot);
text1.FontSize=15;
text1.Color='b';
hold on;

%% ���۲⳵��Q-K�����
line(qk_fit_k,qk_fit_q,'Color','red');
fit_line=strcat('������ߣ�','Q=',num2str(roundn(qk_p(1),-2)),'K+',num2str(roundn(qk_p(2),-2)));
text2=text(avg_k,avg_q+600,fit_line);
text2.FontSize=15;
text2.Color='b';

%% �����ߵ�Q-K��
scatter(all_k,all_q,50,'y','d','filled');
all_plot=strcat('����ƽ��ֵ���꣺','(',num2str(roundn(all_k,-2)),',',num2str(roundn(all_q,-2)),')');
text3=text(avg_k,avg_q+400,all_plot);
text3.FontSize=15;
text3.Color='b';
hold on;

%% ���⼰������
xlabel('�ܶ�K ��λ����/km');
ylabel('����Q ��λ����/h');
title('Q-K����ͼ');

%% ����ͼ��
print('Q-K','-dpng','-r300');