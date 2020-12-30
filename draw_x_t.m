%% ��X-T�켣ɢ��ͼ
clc;
%% ����ͼ��
fig=figure( 'Name', 'x-tͼ' );
fig.WindowState='fullscreen';

%% ��ͼ
for i=1:N
    temp_t=2;
    for t=2:TIME-1
        if x_s( i, t+1 )<x_s( i, t )%�����������
            plot(temp_t:t , x_s( i, temp_t:t ), 'Color', [0.3,0.3,1]);
            temp_t=t+1;
            hold on;
        end
    end
    plot( temp_t:TIME, x_s( i, temp_t:TIME ), 'Color', [0.3,0.3,1]);%����ʣ��켣
    hold on;
end

%% ���⼰������
ylabel( 'λ��X ��λ����(m)' );
xlabel( 'ʱ��T ��λ����(s)' );
title( 'X-T�켣ͼ' );
hold on;

%% ����ͼƬ
print( 'X-T','-dpng', '-r300' );