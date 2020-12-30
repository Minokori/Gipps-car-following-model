%% ��V-Qɢ��ͼ
clc;
%% ����ͼ��
fig=figure( 'name', 'V-K����ͼ' );
fig.WindowState='fullscreen';

%% ���۲⳵��V-Qɢ��ͼ
scatter( q_s, v_s, 10, [0.3,0.3,1], 'filled' );
hold on;

%% ���۲⳵��V-Qƽ��ֵ
scatter( avg_q, avg_v, 50, 'red', 'd', 'filled' );
hold on;
avg_plot=strcat( '�۲⳵ƽ��ֵ���꣺', '(', num2str(roundn(avg_k,-2)), ',', num2str(roundn( avg_v, -2 ) ), ')' );
text1=text( avg_q, avg_v+15, avg_plot );
text1.FontSize=15;
text1.Color='b';
hold on;

%% ���۲⳵��V-Q�����
plot( vq_fit_q,vq_fit_v, 'Color','red' );
fit_plot=strcat( '������ߣ�', 'V=', num2str( vq_p( 1 ) ), 'Q^2+', num2str( vq_p( 2 ) ), 'Q', num2str( vq_p ( 3 ) ) );
text2=text( avg_q, avg_v+25, fit_plot );
text2.FontSize=15;
text2.Color='b';
hold on;

%% �����ߵ�V-Q��
scatter( all_q, all_v,50, 'y','d', 'filled' );
all_plot=strcat( '����ƽ��ֵ���꣺', '(', num2str( roundn( all_q, -2 ) ), ',', num2str( roundn( all_v ,-2 ) ), ')' );
text3=text( avg_q, avg_v+20, all_plot );
text3.FontSize=15;
text3.Color='b';
hold on;

%% ���⼰������
xlabel( '����Q ��λ��veh/h' );
ylabel( '�ٶ�V ��λ��km/h' );
title( 'V-Q����ͼ' );

%% ����ͼ��
print( 'V-Q', '-dpng', '-r300' );