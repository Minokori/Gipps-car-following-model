%% Gippsģ��
clear;clc;

%% ��������
%
load Gipps_start.mat;

%% ���������м����

%��Ӧ����
as=ceil( act_time/dt );%Ӧ����Ϊact_step������ʹ���ʽϸߣ����Ϊas //ceilΪ����ȡ��

%�� i ������ �� i -1 �����ľ������
d=zeros( N, STEP );%d[i,t]����Ϊ�� i �����ڵ� t ����� i-1 �����ľ��룬m
%��ʼ�������
for i=1:N
    if i==1
        d( 1, 1 )=x( N, 1 )+ring-x( 1, 1 );%�� 1 �����Ե� N ����Ϊǰ��
    else
        d( i, 1 )=x( i-1, 1 )-x( i, 1 );
    end
end

%������ر�־
bottle_signal=0;%���������־����ʼ����ֵΪFalse
t_bottle_begin= inf;%�������̿�ʼʱ�䣬��ʼ�������

%% Gippsģ�͵���

for t=2:STEP %�����ѭ��Ϊ���ᣬ��ÿ������x��d��v��a������ɺ󣬽�����һ��
    %% ����ƿ��
    if t>=10*as%�ӵ� 10*as ����ʼ����ƿ��
        if bottle_signal==0 %��ƿ�������ڷ�����״̬�����ж����Ƿ������������
            if rand( 1 )<p_bottle
                bottle_signal=1;%��������־ΪTure
                t_bottle_begin=t;%��¼������ʼʱ��
            end
        end
        if bottle_signal==1 && t>t_bottle_begin+3*as%��������������ָ���־λ  //ƿ��ʱ��Ϊ������Ӧʱ��
            bottle_signal=0;
            t_bottle_begin=inf;
        end
    end
    
    %% λ�ø���
    for i=1:N 
        x( i, t )=update_x( x, v, i, t );%λ�ø������� 
    end
    
    %% �������
    for i=1:N 
        d( i, t )=update_d( x, i, t );%���� i ����ǰ��(i-1)�ľ���
    end
    
    %% �ٶȸ���
    for i=1:N
        v( i, t )=update_v( v, a, i, t );%�ٶȸ���
        %Gippsģ���в�û�жԼ��ٶ� a �����������ڽ�ģ��ʹ�� a ��Ϊ�м������� v �� t �ı仯��ϵ
    end
    
    %% ���ٶȸ���
    %
    for i=1:N
        if i==1%�� 1 �������� N ����Ϊǰ��
            %% Gipps ����
            if t<=as%����ʱ��С�ڷ�Ӧʱ�䣬���ٶȲ���
                a( 1, t )=a( 1, t-1 );
            else %����ʱ����ڷ�Ӧʱ��
                
                %% Gripps ����״̬�ٶȼ���
                v_ff=calcu_v_ff( v( 1, t-as ) );%���ɼ���״̬�ٶ�
                v_cf=calcu_v_cf( v( 1, t-as) , v( N, t-as ) , d( 1, t-as ) );%��ȫ�������ٶ�
                v_next=min( v_ff, v_cf );%v_nextΪGipps���۵��ٶ�
                
                %% ���ٶȼ���
               a( 1, t )=update_a( v_next, v( 1, t ) );%���ٶȸ���
               
               %% ƿ������ƿ��������ʽ
               
               %�������
               if bottle_signal==1 
                   if t==t_bottle_begin%ƿ����ʼ
                       v_bottle_begin=v( 1, t );%��¼ƿ����ʼʱƿ�������ٶ�
                       a( 1, t )=-v_bottle_begin/as;%ƿ������һ����Ӧʱ����ʧ����0
                   elseif t< t_bottle_begin+as
                       a( 1, t )=-v_bottle_begin/as;
                   elseif t< t_bottle_begin+2*as%ƿ�����ڵڶ�����Ӧʱ��ֹͣ
                       a(1,t)=0;
                   elseif t<=t_bottle_begin+3*as%ƿ�����ڵ�������Ӧʱ�����½������״̬
                       v_next=calcu_v_cf( v( 1, t-as ) , v( N, t-as ) , d( 1, t-as ) );
                      a(1,t)=update_a(v_next , v(1,t) );
                   end
               end
               
               %��ʻ����ģ��
               if d( 1, t )>=2*car_length && bottle_signal==0%��ƿ�������־�ǰ������Զ������׷��״̬
                   a( 1, t )=react_speed/as;%ƿ������ȡð�յļ�ʻ��Ϊ�����ϴ�ļ��ٶ�
               end
               
               %% ģ�ⲻ�����ļ�ʻ����
               % �����ٶȼ��������
               a( 1, t )=a( 1, t )+rand( 1 );
               a( 1, t )=min( a( 1, t ), A );
               a( 1, t )=max( a( 1, t ), B );
               
            end
            
        else %i !=1 ��һ�����
            
             %% Gipps ����
             
             if t<=as%������ʱ��С�ڷ�Ӧʱ�䣬���ٶȲ���
                 a( i, t )=a( i, t-1 );
             else%����ʱ����ڷ�Ӧʱ��
                 
                %% Gipps ����״̬�ٶȼ���
                v_ff=calcu_v_ff( v( i, t-as ) );%���ɼ���״̬�ٶ�
                v_cf=calcu_v_cf( v( i, t-as ) , v( i-1, t-as ) , d( i, t-as ) );%��ȫ�������ٶ�
                v_next=min( v_ff, v_cf );%v_nextΪGipps���۵��ٶ�
                
                %% ����� t ���ļ��ٶ�
                a( i, t )=update_a( v_next, v( i, t ) );%���ٶȸ���
                
                %% ģ�ⲻ�����ļ�ʻ����
                if i~=N
                    a( i, t )=a( i, t )+rand( 1 );% �����ٶȼ��������
                    a( i, t )=min( a( i, t ), A );
                    a( i, t )=max( a( i, t ), B );
                end
                
            end
        end
    end
end

%% �����ʱ����

clear i;clear t;clear bottle_signal;clear t_bottle_begin; clear v_cf;clear v_ff; clear v_next;

%% ��������

save Gipps.mat;%�������ս��
xlswrite('Gipps.xlsx',x,1);%��������
xlswrite('Gipps.xlsx',v,2);%��������
xlswrite('Gipps.xlsx',a,3);%��������
xlswrite('Gipps.xlsx',d,4);%��������