function [a_next] = update_a( v_next , v )
%���ٶȸ������麯��
%�����м����v_next��t  ���ٶ�v����� t �ļ��ٶ�
global v_f; global A; global B; global dt;
 v_next=min( v_next, v_f );%�ٶȲ�����Ҫ���ٶ�
 v_next=max( v_next, 0 );%ɲ������ͣ��ʱ�ٶȲ�С��0
 a_next=( v_next-v )/dt;
 a_next=min( a_next, A );%���ٶȲ����������ٶ�
 a_next=max( a_next, B );%���ٶȲ�С����С���ٶ�
end