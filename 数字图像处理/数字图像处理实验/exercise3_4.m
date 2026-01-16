% 读取原始图像 
I = imread('cameraman.tif');

% 1. 添加高斯噪声
I_gaussian = imnoise(I, 'gaussian', 0, 0.02);

% 2. 下采样 (降采样)
% 先缩小再放大，模拟分辨率降低的效果
I_downsampled = imresize(imresize(I, 0.25, 'bilinear'), 4, 'bilinear');

% 3. 运动模糊
h_motion = fspecial('motion', 20, 45); % 长度20，角度45
I_motion_blur = imfilter(I, h_motion, 'replicate');

% 4. 散焦模糊 (均值模糊)
h_disk = fspecial('disk', 10); % 半径为10的圆形均值滤波器
I_defocus_blur = imfilter(I, h_disk, 'replicate');

% 显示结果
figure;
subplot(2,3,1); imshow(I); title('原始图像');
subplot(2,3,2); imshow(I_gaussian); title('高斯噪声');
subplot(2,3,3); imshow(I_downsampled); title('下采样');
subplot(2,3,4); imshow(I_motion_blur); title('运动模糊');
subplot(2,3,5); imshow(I_defocus_blur); title('散焦模糊');
