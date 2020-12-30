%% ���ݷ���
clear;clc;

%% ��������
load Gipps.mat;

%% ��X-Tͼ׼������
%ÿ��ȡֵ
x_s=zeros( N, TIME );
for i=1:N
    for t=1:TIME
        x_s( i, t )=x( i, t*10 );
    end
end

%% ��������ͼ׼������

%����󳵾�
d_max=zeros( 1, STEP );
for t=1:STEP
    d_max( t )=max( d( :, t ) );
end

%ÿ��ȡֵ
d_max_s=zeros( 1, TIME );
for t=1:TIME
    d_max_s( 1, t )=d_max( 1, t*10 );
end

%% ��Q-K-Vͼ׼������

%���۲⳵������
% �����������q��k��v
s=zeros( 1, STEP );
qkv_d=zeros( 1, STEP );
qkv_k=zeros( 1, STEP );
qkv_q=zeros( 1, STEP );
% ����ȡֵ
for t=1:STEP
    qkv_d( 1, t )=d(N,t)/1000;%���࣬��λ��km //����dֻ��������k���м����
    qkv_k( 1, t )=1/( qkv_d( 1, t ) );%����ĵ�����Ϊ�ܶȣ���λ��veh/km
    qkv_q( 1, t )=qkv_k( 1, t )*( v( N, t )*3.6 );%��������λ��veh/h
end
qkv_v=v( N, : )*3.6;%�ٶȣ���λkm/h

%��k��v��q����һ��������
k_v_q=zeros( STEP, 3 );
k_v_q( :, 1 )=qkv_k;
k_v_q( :, 2 )=qkv_v;
k_v_q( :, 3 )=qkv_q;

%ÿ��ȡֵ
q_s=zeros( 1, TIME );
k_s=zeros( 1, TIME );
for i=1:N
    for t=1:TIME
        q_s( 1, t )=k_v_q( t*10, 3 );
        k_s( 1, t )=k_v_q( t*10, 1 );
        v_s( 1, t )=k_v_q( t*10, 2 );
    end
end

%��ƽ��ֵ
avg_k=sum( k_s )/TIME;
avg_q=sum( q_s )/TIME;
avg_v=sum( v_s )/TIME;

%��Q-K���ֱ��
qk_p = polyfit( qkv_k, qkv_q, 1 );%Q-K������ֱ�����
qk_fit_k=[min( k_s ),max( k_s ) ];%�����������
qk_fit_q=qk_p( 1 )*qk_fit_k+qk_p( 2 );

%��K-V�������
dv_p = polyfit( qkv_v, qkv_d, 2 );%K-V�����þ���D���м�ֵ����ʽ���
dv_fit_v=min( v_s ):max( v_s );%�����������
dv_fit_d=dv_p( 1 )*dv_fit_v.^2+dv_p( 2 )*dv_fit_v+dv_p( 3 );
dv_fit_k=1./dv_fit_d;%��D-V�������K-V����

%��V-Q�������
vq_p = polyfit( qkv_q, qkv_v, 2 );%V-Q�����ö���ʽ���
vq_fit_q=min( q_s ):max( q_s );%�����������
vq_fit_v=vq_p( 1 )*vq_fit_q.^2+vq_p( 2 )*vq_fit_q+vq_p( 3 );

%������K-V��ϵ����
exp_v=0:max( v_s );
exp_s=( 3*act_time/3600/2 ).*exp_v+car_length/1000;%��΢�۵���۵�λת��
exp_k=1./( exp_s );%�����������

% ���������ߵ�Q-K-V��
all_k=N/( ring/1000 );
all_v=mean( v, 'all' )*3.6;
all_q=all_k*all_v;
%% ��������
save Gipps_analysis.mat;

