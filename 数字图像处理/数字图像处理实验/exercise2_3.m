% 读取灰度图像 
I = imread('pout.tif'); % pout.tif是MATLAB自带的低对比度图像

% 1. 灰度反转
I_inv = 255 - I;

% 2. 对数变换
I_double = im2double(I); % 转换为double类型
c = 1 / log(1 + max(I_double(:))); % 计算常数c
I_log = c * log(1 + I_double);

% 3. 显示结果
figure;
subplot(1,3,1);
imshow(I);
title('原始图像');

subplot(1,3,2);
imshow(I_inv);
title('灰度反转');

subplot(1,3,3);
imshow(I_log);
title('对数变换');