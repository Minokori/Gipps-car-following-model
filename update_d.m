function [d_next] = update_d( x, i, s)
%������㺯��
%���� λ������x���������i�����沽��s�����d( i, s )
global ring;  global N;
%% ����ǰ�����͸��۳�
if i==1
    num_bk=1; num_fr=N;
else
    num_bk=i; num_fr=i-1;
end
%% �������
if ( x( num_bk, s )==max( x( :, s ) ) ) && ( x( num_fr, s )==min( x( :, s ) ) )%�ж�ǰ�����͸��۳��Ƿ�����
    d_next=x( num_fr, s )-x( num_bk, s )+ring;%��������
else
    d_next=x( num_fr, s )-x( num_bk, s );
end

end