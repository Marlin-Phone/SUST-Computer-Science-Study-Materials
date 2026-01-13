% 1. 已知数据点
x = [0, 1, 2, 3];
y = [1, 3, 9, 27];
xi = 1.25; % 插值点

% (1) 分段线性插值
yi_linear = interp1(x, y, xi, 'linear');

% (2) 三次样条插值
yi_spline = interp1(x, y, xi, 'spline');

% (3) 拉格朗日插值 (需要自定义函数或使用符号计算)
% 这里使用一个简单的循环实现
n = length(x);
yi_lagrange = 0;
for i = 1:n
    L = 1;
    for j = 1:n
        if i ~= j
            L = L * (xi - x(j)) / (x(i) - x(j));
        end
    end
    yi_lagrange = yi_lagrange + y(i) * L;
end

% 输出结果
fprintf('当 x = %.2f 时:\n', xi);
fprintf('分段线性插值 y = %.4f\n', yi_linear);
fprintf('三次样条插值 y = %.4f\n', yi_spline);
fprintf('拉格朗日插值 y = %.4f\n', yi_lagrange);

% 真实值 (y=3^x)
y_true = 3^xi;
fprintf('函数真实值 y = %.4f\n', y_true);