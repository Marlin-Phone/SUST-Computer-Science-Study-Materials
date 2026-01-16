% 读取一幅高分辨率图像 
I = imread('cameraman.tif'); % cameraman.tif是MATLAB自带图像
I = im2double(I); % 转换为double类型便于处理

% 1. 空间分辨率降低 (模拟图2.3.5效果)
figure;
subplot(2,2,1);
imshow(I);
title('原始图像 (256x256)');

% 降低到128x128
I_128 = imresize(imresize(I, 0.5), 2, 'nearest');
subplot(2,2,2);
imshow(I_128);
title('空间分辨率 128x128');

% 降低到64x64
I_64 = imresize(imresize(I, 0.25), 4, 'nearest');
subplot(2,2,3);
imshow(I_64);
title('空间分辨率 64x64');

% 降低到32x32
I_32 = imresize(imresize(I, 0.125), 8, 'nearest');
subplot(2,2,4);
imshow(I_32);
title('空间分辨率 32x32');

% 2. 灰度分辨率降低 (模拟图2.3.6效果)
figure;
I_gray = imread('cameraman.tif'); % 重新读取为uint8类型

subplot(2,2,1);
imshow(I_gray);
title('原始图像 (256级灰度)');

% 降低到128级灰度
I_128_gray = grayslice(I_gray, 128);
subplot(2,2,2);
imshow(I_128_gray, gray(128));
title('128级灰度');

% 降低到32级灰度
I_32_gray = grayslice(I_gray, 32);
subplot(2,2,3);
imshow(I_32_gray, gray(32));
title('32级灰度');

% 降低到2级灰度 (二值图像)
I_2_gray = grayslice(I_gray, 2);
subplot(2,2,4);
imshow(I_2_gray, gray(2));
title('2级灰度 (二值)');