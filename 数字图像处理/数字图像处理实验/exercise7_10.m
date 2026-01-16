% 读取图像并转为double 
img = im2double(imread('cameraman.tif'));

% 1. 添加高斯白噪声
noise_variance = 0.005;
noisy_img = img + sqrt(noise_variance) * randn(size(img));

% 2. 使用MATLAB的 wdenoise 函数进行去噪 (推荐的现代方法)
% 硬阈值去噪
img_denoised_hard = wdenoise2(noisy_img, 'ThresholdRule', 'Hard');
% 软阈值去噪
img_denoised_soft = wdenoise2(noisy_img, 'ThresholdRule', 'Soft');

% 计算RMSE以评估效果
rmse_noisy = sqrt(mean((img(:) - noisy_img(:)).^2));
rmse_hard = sqrt(mean((img(:) - img_denoised_hard(:)).^2));
rmse_soft = sqrt(mean((img(:) - img_denoised_soft(:)).^2));

% 显示结果
figure;
subplot(2,2,1); imshow(img); title('原始图像');
subplot(2,2,2); imshow(noisy_img);
title(sprintf('含噪图像 (RMSE=%.4f)', rmse_noisy));
subplot(2,2,3); imshow(img_denoised_hard);
title(sprintf('硬阈值去噪 (RMSE=%.4f)', rmse_hard));
subplot(2,2,4); imshow(img_denoised_soft);
title(sprintf('软阈值去噪 (RMSE=%.4f)', rmse_soft));