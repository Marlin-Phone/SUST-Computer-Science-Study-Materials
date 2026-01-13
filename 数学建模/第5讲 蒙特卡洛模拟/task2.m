%% 蒙特卡洛模拟估算圆周率π
clear all; close all; clc;

% 1. 实验参数设置
N = 10^7;        % 生成随机点数量，可调整N值观察精度变化
r = 1;           % 圆半径
x_min = 0; x_max = r;   % 第一象限x范围
y_min = 0; y_max = r;   % 第一象限y范围
square_area = r^2;       % 正方形面积（第一象限）

% 2. 生成随机点并统计
rng('default');  % 固定随机数生成器
x = x_min + (x_max-x_min)*rand(N, 1);  % 生成x坐标
y = y_min + (y_max-y_min)*rand(N, 1);  % 生成y坐标
inside = (x.^2 + y.^2) <= r^2;         % 判断点是否在圆内（第一象限）
n_inside = sum(inside);                % 统计圆内点数

% 3. 估算π并输出
pi_estimate = 4 * (n_inside/N) * square_area / r^2;
fprintf('π的估算值：%.10f\n', pi_estimate);
fprintf('理论值：%.10f\n', pi);
fprintf('绝对误差：%.10f\n', abs(pi_estimate-pi));
fprintf('相对误差：%.6f%%\n', abs(pi_estimate/pi-1)*100);

% 4. 可视化（可选）
if N <= 1e5  % 点数量较少时绘制散点图
    figure;
    hold on;
    % 绘制圆理论曲线（第一象限）
    t = linspace(0, pi/2, 100);
    plot(r*cos(t), r*sin(t), 'r-', 'LineWidth', 2);
    % 绘制正方形边界
    plot([0 r r 0 0], [0 0 r r 0], 'k--', 'LineWidth', 1);
    % 绘制随机点（绿色在圆内，红色在圆外）
    plot(x(inside), y(inside), 'g.', 'MarkerSize', 5);
    plot(x(~inside), y(~inside), 'r.', 'MarkerSize', 5);
    % 设置图形属性
    axis equal;
    title('蒙特卡洛模拟估算π');
    xlabel('x'); ylabel('y');
    legend('1/4圆周', '正方形边界', '圆内点', '圆外点');
    grid on;
end