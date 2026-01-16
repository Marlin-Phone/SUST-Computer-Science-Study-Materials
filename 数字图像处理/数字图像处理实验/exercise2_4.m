%  直方图均衡化  
I = imread('pout.tif'); % 读取低对比度图像

I_eq = histeq(I); % 进行直方图均衡化

figure;
subplot(2,2,1);
imshow(I);
title('原始图像');
subplot(2,2,2);
imhist(I);
title('原始直方图');

subplot(2,2,3);
imshow(I_eq);
title('均衡化后图像');
subplot(2,2,4);
imhist(I_eq);
title('均衡化后直方图');
% 应用说明：均衡化显著增强了图像的全局对比度，直方图分布更广。

%  直方图规定化  
I_source = imread('cameraman.tif'); % 源图像
I_target = imread('rice.png');      % 目标图像 (我们想让源图像有类似rice.png的直方图)

I_matched = imhistmatch(I_source, I_target); % 进行直方图规定化

figure;
subplot(2,3,1);
imshow(I_source);
title('源图像');
subplot(2,3,4);
imhist(I_source);

subplot(2,3,2);
imshow(I_target);
title('目标图像');
subplot(2,3,5);
imhist(I_target);

subplot(2,3,3);
imshow(I_matched);
title('规定化后图像');
subplot(2,3,6);
imhist(I_matched);
% 应用说明：规定化后的图像在视觉上呈现出与目标图像相似的亮度和对比度特性。