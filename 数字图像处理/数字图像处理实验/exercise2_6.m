% 读取图像并添加噪声 
I = imread('cameraman.tif');
I_noisy = imnoise(I, 'gaussian', 0, 0.01); % 添加高斯噪声

% 创建不同大小的均值和高斯滤波器
h_mean_3 = fspecial('average', [3 3]);
h_mean_7 = fspecial('average', [7 7]);
h_gauss_3 = fspecial('gaussian', [3 3], 0.5);
h_gauss_7 = fspecial('gaussian', [7 7], 1.2);

% 应用滤波器
I_mean_3 = imfilter(I_noisy, h_mean_3);
I_mean_7 = imfilter(I_noisy, h_mean_7);
I_gauss_3 = imfilter(I_noisy, h_gauss_3);
I_gauss_7 = imfilter(I_noisy, h_gauss_7);

% 显示结果
figure;
subplot(2,3,1); imshow(I_noisy); title('含噪图像');
subplot(2,3,2); imshow(I_mean_3); title('3x3 均值滤波');
subplot(2,3,3); imshow(I_mean_7); title('7x7 均值滤波');
subplot(2,3,4); imshow(I_noisy); title('含噪图像'); % 再次显示以便比较
subplot(2,3,5); imshow(I_gauss_3); title('3x3 高斯滤波');
subplot(2,3,6); imshow(I_gauss_7); title('7x7 高斯滤波');