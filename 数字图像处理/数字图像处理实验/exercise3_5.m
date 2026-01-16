% 读取图像并添加椒盐噪声 
I = imread('cameraman.tif');
I_sp_noisy = imnoise(I, 'salt & pepper', 0.05); % 添加5%的椒盐噪声

% 应用中值滤波
I_median_filtered = medfilt2(I_sp_noisy, [3 3]);

% 显示结果
figure;
subplot(1,3,1); imshow(I); title('原始图像');
subplot(1,3,2); imshow(I_sp_noisy); title('含椒盐噪声图像');
subplot(1,3,3); imshow(I_median_filtered); title('3x3中值滤波后');