
% 读取图像 
img = im2double(imread('cameraman.tif'));

% 添加高斯噪声
noisy_img = imnoise(img, 'gaussian', 0, 0.01);

% 计算均方根误差 (RMSE)
diff_img = img - noisy_img;
mse = mean(diff_img(:).^2); % 均方误差
rmse = sqrt(mse);

% 计算均方根信噪比 (SNR) in dB
signal_power = mean(img(:).^2);
noise_power = mse;
snr_dB = 10 * log10(signal_power / noise_power);

% 显示结果
figure;
subplot(1,2,1); imshow(img); title('原始图像');
subplot(1,2,2); imshow(noisy_img); title('含噪图像');

fprintf('原始图像与含噪图像之间的:\n');
fprintf('均方根误差 (RMSE): %.4f\n', rmse);
fprintf('均方根信噪比 (SNR): %.2f dB\n', snr_dB);