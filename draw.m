%% 绘图
clear; clc;
%% 加载数据
load Gipps_analysis.mat;
%% 绘图
draw_x_t;%画X-T位置轨迹散点图
draw_q_k;%画Q-K基本图
draw_k_v;%画K-V基本图
draw_v_q;%画V-Q基本图
draw_max_d;%画最大距离散点图