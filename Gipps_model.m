%% Gipps模型
clear;clc;

%% 加载数据
%
load Gipps_start.mat;

%% 计算必须的中间变量

%反应步长
as=ceil( act_time/dt );%应命名为act_step，由于使用率较高，简记为as //ceil为向上取整

%第 i 辆车与 第 i -1 辆车的距离矩阵
d=zeros( N, STEP );%d[i,t]意义为第 i 辆车在第 t 步与第 i-1 辆车的距离，m
%初始距离计算
for i=1:N
    if i==1
        d( 1, 1 )=x( N, 1 )+ring-x( 1, 1 );%第 1 辆车以第 N 辆车为前车
    else
        d( i, 1 )=x( i-1, 1 )-x( i, 1 );
    end
end

%慢化相关标志
bottle_signal=0;%随机慢化标志，初始布尔值为False
t_bottle_begin= inf;%慢化过程开始时间，初始置无穷大

%% Gipps模型迭代

for t=2:STEP %最外层循环为步轴，即每辆车的x，d，v，a更新完成后，进行下一步
    %% 产生瓶颈
    if t>=10*as%从第 10*as 步开始产生瓶颈
        if bottle_signal==0 %若瓶颈车处于非慢化状态，则判定其是否进行慢化过程
            if rand( 1 )<p_bottle
                bottle_signal=1;%置慢化标志为Ture
                t_bottle_begin=t;%记录慢化开始时间
            end
        end
        if bottle_signal==1 && t>t_bottle_begin+3*as%随机慢化结束，恢复标志位  //瓶颈时间为三个反应时长
            bottle_signal=0;
            t_bottle_begin=inf;
        end
    end
    
    %% 位置更新
    for i=1:N 
        x( i, t )=update_x( x, v, i, t );%位置更新与检查 
    end
    
    %% 距离更新
    for i=1:N 
        d( i, t )=update_d( x, i, t );%计算 i 车与前车(i-1)的距离
    end
    
    %% 速度更新
    for i=1:N
        v( i, t )=update_v( v, a, i, t );%速度更新
        %Gipps模型中并没有对加速度 a 进行描述，在建模中使用 a 作为中间量建立 v 随 t 的变化关系
    end
    
    %% 加速度更新
    %
    for i=1:N
        if i==1%第 1 辆车将第 N 车作为前车
            %% Gipps 计算
            if t<=as%迭代时间小于反应时间，加速度不变
                a( 1, t )=a( 1, t-1 );
            else %迭代时间大于反应时间
                
                %% Gripps 跟驰状态速度计算
                v_ff=calcu_v_ff( v( 1, t-as ) );%自由加速状态速度
                v_cf=calcu_v_cf( v( 1, t-as) , v( N, t-as ) , d( 1, t-as ) );%安全许可最大速度
                v_next=min( v_ff, v_cf );%v_next为Gipps跟驰的速度
                
                %% 加速度计算
               a( 1, t )=update_a( v_next, v( 1, t ) );%加速度更新
               
               %% 瓶颈车的瓶颈产生形式
               
               %随机慢化
               if bottle_signal==1 
                   if t==t_bottle_begin%瓶颈开始
                       v_bottle_begin=v( 1, t );%记录瓶颈开始时瓶颈车的速度
                       a( 1, t )=-v_bottle_begin/as;%瓶颈车在一个反应时间内失速至0
                   elseif t< t_bottle_begin+as
                       a( 1, t )=-v_bottle_begin/as;
                   elseif t< t_bottle_begin+2*as%瓶颈车在第二个反应时间停止
                       a(1,t)=0;
                   elseif t<=t_bottle_begin+3*as%瓶颈车在第三个反应时间重新进入跟驰状态
                       v_next=calcu_v_cf( v( 1, t-as ) , v( N, t-as ) , d( 1, t-as ) );
                      a(1,t)=update_a(v_next , v(1,t) );
                   end
               end
               
               %驾驶心理模拟
               if d( 1, t )>=2*car_length && bottle_signal==0%若瓶颈车发现距前导车过远，进入追赶状态
                   a( 1, t )=react_speed/as;%瓶颈车采取冒险的驾驶行为，即较大的加速度
               end
               
               %% 模拟不完美的驾驶过程
               % 给加速度加上随机数
               a( 1, t )=a( 1, t )+rand( 1 );
               a( 1, t )=min( a( 1, t ), A );
               a( 1, t )=max( a( 1, t ), B );
               
            end
            
        else %i !=1 的一般情况
            
             %% Gipps 计算
             
             if t<=as%若迭代时间小于反应时间，加速度不变
                 a( i, t )=a( i, t-1 );
             else%迭代时间大于反应时间
                 
                %% Gipps 跟驰状态速度计算
                v_ff=calcu_v_ff( v( i, t-as ) );%自由加速状态速度
                v_cf=calcu_v_cf( v( i, t-as ) , v( i-1, t-as ) , d( i, t-as ) );%安全许可最大速度
                v_next=min( v_ff, v_cf );%v_next为Gipps跟驰的速度
                
                %% 计算第 t 步的加速度
                a( i, t )=update_a( v_next, v( i, t ) );%加速度更新
                
                %% 模拟不完美的驾驶过程
                if i~=N
                    a( i, t )=a( i, t )+rand( 1 );% 给加速度加上随机数
                    a( i, t )=min( a( i, t ), A );
                    a( i, t )=max( a( i, t ), B );
                end
                
            end
        end
    end
end

%% 清除临时变量

clear i;clear t;clear bottle_signal;clear t_bottle_begin; clear v_cf;clear v_ff; clear v_next;

%% 保存数据

save Gipps.mat;%保存最终结果
xlswrite('Gipps.xlsx',x,1);%保存数据
xlswrite('Gipps.xlsx',v,2);%保存数据
xlswrite('Gipps.xlsx',a,3);%保存数据
xlswrite('Gipps.xlsx',d,4);%保存数据