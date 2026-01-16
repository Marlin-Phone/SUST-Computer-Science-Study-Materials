% 读取图像 
I = im2double(imread('cameraman.tif'));

% 定义用于计算偏导数的Sobel算子
sobel_x = [-1 0 1; -2 0 2; -1 0 1]; % 检测垂直边缘
sobel_y = sobel_x'; % 检测水平边缘 (sobel_x的转置)

% 计算偏导数
Gx = imfilter(I, sobel_x, 'replicate');
Gy = imfilter(I, sobel_y, 'replicate');

% 计算梯度模
G = sqrt(Gx.^2 + Gy.^2);

% 显示结果
figure;
subplot(2,2,1); imshow(I); title('原始图像');
subplot(2,2,2); imshow(Gx, []); title('水平偏导数 Gx'); % []用于自动调整显示范围
subplot(2,2,3); imshow(Gy, []); title('垂直偏导数 Gy');
subplot(2,2,4); imshow(G, []); title('梯度模 G');