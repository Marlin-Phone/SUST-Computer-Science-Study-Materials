
% 读取图像并添加椒盐噪声 
I = imread('cameraman.tif');
I_sp_noisy = imnoise(I, 'salt & pepper', 0.05); % 添加5%的椒盐噪声

% 应用中值滤波
I_median_3 = medfilt2(I_sp_noisy, [3 3]); % 使用3x3模板
I_median_5 = medfilt2(I_sp_noisy, [5 5]); % 使用5x5模板

% 为了对比，也应用均值滤波
h_mean_3 = fspecial('average', [3 3]);
I_mean_3 = imfilter(I_sp_noisy, h_mean_3);

% 显示结果
figure;
subplot(2,2,1); imshow(I_sp_noisy); title('含椒盐噪声图像');
subplot(2,2,2); imshow(I_mean_3); title('3x3 均值滤波');
subplot(2,2,3); imshow(I_median_3); title('3x3 中值滤波');
subplot(2,2,4); imshow(I_median_5); title('5x5 中值滤波');