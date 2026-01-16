
% 读取图像 
img = imread('cameraman.tif');
img_double = im2double(img);

% 1. 对图像做3层小波分解
wname = 'db4'; % 选择 Daubechies-4 小波
level = 3;
[C, S] = wavedec2(img_double, level, wname);

% C 是一个长向量，包含了所有层的小波系数
% S 是一个记录各层系数维度的矩阵

% 2. 绘制原始图像灰度直方图
figure;
subplot(1,2,1);
imhist(img);
title('原始图像灰度直方图');

% 3. 绘制小波系数直方图
% 为了更好地可视化，我们排除最大的近似系数(低频分量)
approx_coeffs_len = S(1,1) * S(1,2);
detail_coeffs = C(approx_coeffs_len+1:end);

subplot(1,2,2);
histogram(detail_coeffs, 100);
title('小波细节系数直方图');
xlabel('系数幅值');
ylabel('数量');
set(gca, 'YScale', 'log'); % 使用对数坐标轴，以便观察