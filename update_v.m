function [v_next] = update_v( v, a, i, s )
%�ٶȸ������麯��
%���� �ٶ�����v�����ٶ�����a���������i�����沽��s�����v( i, s )
global dt; 
v_next=v( i, s-1)+a( i, s-1)*dt;
if v_next<=0
    v_next=0;
end
end

