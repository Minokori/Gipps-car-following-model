function [x_next] = update_x( x, v, i, s )
%λ�ø������麯��
%���� λ������x���ٶ�����v���������i�����沽��s�����x( i, s )
global dt; global ring;
x_next=x( i, s-1)+v(i ,s-1 )*dt;
%λ�ü��
if x_next>=ring
   x_next=x_next-ring;
if x_next<=0
   x_next=x_next+ring;
end
end