% 3. 水深数据
x = [129, 140, 103.5, 88, 185.5, 195, 105.5, 157.5, 107.5, 77, 81, 162, 162, 117.5]; 
y = [7.5, 141.5, 23, 147, 22.5, 137.5, 85.5, -6.5, -81, 3, 56.5, -66.5, 84, -33.5]; 
z = [-4, -8, -6, -8, -6, -8, -8, -9, -9, -8, -8, -9, -4, -9]; 

% 定义矩形区域
x_range = 75:1:200;
y_range = -50:1:150;
[X, Y] = meshgrid(x_range, y_range);

% 对水深数据进行二维插值
Z = griddata(x, y, z, X, Y, 'cubic'); % 使用三次样条插值

% 绘图
figure;
% 绘制水深等高线图
contourf(X, Y, Z);
hold on;
colorbar; % 显示颜色条

% 标记水深小于5米 (z > -5) 的危险区域
contour(X, Y, Z, [-5, -5], 'r', 'LineWidth', 2, 'DisplayName', '危险区域边界 (水深5米)');

% 标记原始数据点
plot(x, y, 'ko', 'MarkerFaceColor', 'w', 'DisplayName', '测量点');
xlabel('经度 x');
ylabel('纬度 y');
title('海域水深分布及危险区域 (水深 < 5米)');
legend;
axis([75 200 -50 150]);
grid on;