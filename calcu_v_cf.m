function [v_cf] = calcu_v_cf( v_bk, v_fr, d)
%��ȫ�������ٶȺ���
%���� t-as ���ٶȣ�ǰ�����ٶȣ����룬��� t ��Gipps�����ٶ�
global B; global act_time; global car_length;
v_cf=B*act_time+sqrt( B^2*act_time^2+B*( v_bk*act_time+v_fr^2/B+2*car_length-2*d ) );%Gipps�����ٶ�
v_cf=real( v_cf );%��������Ϊ����������ʵ��
end

