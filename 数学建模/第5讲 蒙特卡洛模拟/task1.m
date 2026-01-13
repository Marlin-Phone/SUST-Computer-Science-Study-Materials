%% 蒙特卡洛模拟计算椭圆面积：(x²/4)+(y²/9)=1
clear all; close all; clc;

% 1. 实验参数设置
N = 10^6;        % 生成随机点数量，可调整N值观察精度变化
a = 2; b = 3;     % 椭圆参数：x²/a² + y²/b² = 1
x_min = -a; x_max = a;   % 椭圆x范围
y_min = -b; y_max = b;   % 椭圆y范围
rect_area = (x_max-x_min)*(y_max-y_min);  % 包围矩形面积

% 2. 生成随机点并统计
rng('default');  % 固定随机数生成器，确保结果可复现
x = x_min + (x_max-x_min)*rand(N, 1);  % 生成x坐标
y = y_min + (y_max-y_min)*rand(N, 1);  % 生成y坐标
inside = (x.^2/a^2 + y.^2/b^2) <= 1;    % 判断点是否在椭圆内
n_inside = sum(inside);                % 统计椭圆内点数

% 3. 计算椭圆面积并输出
ellipse_area = (n_inside/N) * rect_area;
fprintf('椭圆面积计算结果：%.6f\n', ellipse_area);
fprintf('理论值(π*a*b)：%.6f\n', pi*a*b);
fprintf('相对误差：%.6f%%\n', abs(ellipse_area/pi/a/b-1)*100);

% 4. 可视化（可选）
if N <= 1e4  % 点数量较少时绘制散点图
    figure;
    hold on;
    % 绘制椭圆理论曲线
    t = linspace(0, 2*pi, 100);
    plot(a*cos(t), b*sin(t), 'r-', 'LineWidth', 2);
    % 绘制随机点（绿色在椭圆内，红色在椭圆外）
    plot(x(inside), y(inside), 'g.', 'MarkerSize', 5);
    plot(x(~inside), y(~inside), 'r.', 'MarkerSize', 5);
    % 设置图形属性
    axis equal;
    title('蒙特卡洛模拟椭圆面积');
    xlabel('x'); ylabel('y');
    legend('椭圆曲线', '椭圆内点', '椭圆外点');
    grid on;
end