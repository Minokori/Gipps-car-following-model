function [v_ff] = calcu_v_ff( v_before_act )
%���ɼ���״̬�ٶȺ���
%���� t-as ���ٶȣ���� t �����ɼ���״̬�ٶ�
global A; global act_time; global v_f; 
v_ff=v_before_act+2.5*A*act_time*( 1-v_before_act/v_f )*sqrt( 0.025+v_before_act/v_f );%Gipps�������ٶ�
end