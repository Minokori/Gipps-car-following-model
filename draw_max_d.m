%% ����󳵾�ͼ
clc;

%% ����ͼ��
fig=figure('Name','��󳵾�ͼ');
fig.WindowState='fullscreen';

%% ��ͼ
scatter(1:TIME,d_max_s,4);

%% ���⼰������
ylabel('���ͷ���D ��λ����(m)');
xlabel('ʱ��T ��λ����(s)');
title('���ͷ���');
hold on;

%% ����ͼƬ
print('D_max','-dpng','-r300');