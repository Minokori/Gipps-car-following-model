%% ����Gipps��������
%���ó�ʼ������������
clear;
clc;
%% �������� 
global car_length; car_length=6;%�������ȣ�m
global v_f; v_f=30/3.6;%�����ٶȣ�m/s
global A; A=4;%�����ٶȣ�m/s^2
global B; B=-6;%�����ٶȣ�m/s^2
%% ��ʻԱ����
%
global act_time; act_time=1;%��Ӧʱ�䣬s
react_speed=40/3.6;%Ӧ���ٶ�
%% ʵ�鳡������
%

global ring; ring=230;%���߳��ȣ�m
TIME=1000;%ʵ��ʱ�䣬s����Ϊ���ʱ��
global dt; dt=0.1;%���沽������ÿ0.1s����һ�ε���
STEP=floor( TIME/dt );%ʵ���ܲ�������Ϊ����� //floorΪ����ȡ��
step=1:STEP;%����
global N; N=22;%����������Ϊ���������
n=1:N;%���������Ϊ1-10

%������ز���
p_bottle=0.4;%ƿ������������
%% ���ó�ʼ״̬
%
%����λ�þ���
x=zeros( N, STEP );
%��1�����ĳ�ʼλ����󣬵�N������ԭ��
for i=1:N
    x(i,1)=ring-i*ring/N;%�Ⱦ����ó�����ʼλ��
end
%��ʼ��������Լ��
if ( ring/N<=car_length )
    fprintf("��ʼ����С�ڳ�������");
end

%�����ٶȾ���
v=zeros( N, STEP );
for i=1:N
    v( i, 1 )=v_f+randn;%��ʼ�ٶȣ������ǲ������ļ�ʻ�ٿ���Ϊ //��ʻ�ٶ��������ٶ�[-1,1]����������ֲ�
end

%���ó�ʼ���ٶȾ���
a=zeros( N, STEP );
for i=1:N
    a( i, 1 )=randn;%��ƻ���ʼ���ٶ� //���ٶ���[-1,1]֮������ֲ�
end
%% �����ʱ����
%
clear i;
%% ��������
%���浱ǰ�����ռ�
save Gipps_start.mat;