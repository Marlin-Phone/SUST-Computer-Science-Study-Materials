% 2. 运行并理解三维绘图命令

% (1) 绘制三维螺旋线
figure;
t = 0:pi/50:10*pi;
plot3(t, sin(t), cos(t), 'r:');
title('三维螺旋线');
xlabel('t'); ylabel('sin(t)'); zlabel('cos(t)');
grid on;

% (2) 绘制三维网格曲面
figure;
x = -5:5; y = -10:10;
[X, Y] = meshgrid(x, y);
Z = X.^2 + Y.^2;
mesh(X, Y, Z); 
title('网格曲面 Z = X^2 + Y^2');
xlabel('X'); ylabel('Y'); zlabel('Z');

% (3) 绘制三维球面
figure;
[x, y, z] = sphere(30);
surf(x, y, z); 
title('三维球面');
axis equal; % 使坐标轴比例相同，显示为球体

% (4) 绘制三维空间中的两个圆
figure;
t = 0:pi/100:2*pi;
x = [sin(t) sin(t)];
y = [cos(t) cos(t)];
z = [ones(size(t)) 2*ones(size(t))]; % 简化原z的表达式
% 原表达式: z=[(sin(t)).^2+(cos(t)).^2 (sin(t)).^2+(cos(t)).^2+1 ];
% (sin(t)).^2+(cos(t)).^2 恒等于 1
plot3(x, y, z, 'r:');
title('空间中的两个圆');
xlabel('x'); ylabel('y'); zlabel('z');
grid on;
axis equal;