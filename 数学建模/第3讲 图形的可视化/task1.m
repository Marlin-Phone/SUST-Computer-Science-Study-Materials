% 1. 绘制双曲正弦和双曲余弦函数
x = -3:0.1:3; % 定义自变量范围
y1 = sinh(x); % 计算双曲正弦函数值
y2 = cosh(x); % 计算双曲余弦函数值

% 绘图
figure; % 创建一个新的图形窗口
plot(x, y1, 'b-', 'LineWidth', 2, 'DisplayName', 'y = sinh(x)');
hold on; % 保持当前图形，以便在其上绘制新图形
plot(x, y2, 'r--', 'LineWidth', 2, 'DisplayName', 'y = cosh(x)');
hold off; % 结束在当前图形上继续绘制

% 添加详细标注
title('双曲正弦与双曲余弦函数图像'); % 标题
xlabel('x 轴'); % x轴标签
ylabel('y 轴'); % y轴标签
legend('show'); % 显示图例
grid on; % 显示网格
axis([-3, 3, 0, 12]); % 设置坐标轴范围
text(1.5, sinh(1.5), '\leftarrow sinh(x)', 'FontSize', 10); % 添加文本注释
text(1.5, cosh(1.5), '\leftarrow cosh(x)', 'FontSize', 10);