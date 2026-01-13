% 2. 实验数据
x = [1, 2, 4, 7, 9, 12, 13, 15, 17]; 
y = [1.5, 3.9, 6.6, 11.7, 15.6, 18.8, 19.6, 20.6, 21.1]; 

% 使用二次多项式进行最小二乘拟合
p = polyfit(x, y, 2); % p = [p1, p2, p3] for p1*x^2 + p2*x + p3

% 生成拟合曲线的数据点
x_fit = 1:0.1:17;
y_fit = polyval(p, x_fit);

% 输出拟合的多项式系数
fprintf('拟合的二次多项式为: y = (%.4f)x^2 + (%.4f)x + (%.4f)\n', p(1), p(2), p(3));

% 绘图
figure;
plot(x, y, 'o', 'DisplayName', '原始数据');
hold on;
plot(x_fit, y_fit, 'r-', 'DisplayName', '二次多项式拟合');
xlabel('x');
ylabel('y');
title('实验数据最小二乘拟合');
legend;
grid on;