
% 读取图像 
img = imread('cameraman.tif');

% 1. 绘制原始图像的灰度直方图
figure;
subplot(1,2,1);
imhist(img);
title('原始图像灰度直方图');
xlim([0 255]);

% 2. 对8x8块进行DCT并计算系数直方图
img_double = im2double(img);
[rows, cols] = size(img_double);
dct_coeffs = [];

% 使用blkproc函数 (或 blockproc) 对8x8块进行DCT
% 定义DCT函数句柄
dct_fun = @(block_struct) dct2(block_struct.data);
B = blockproc(img_double, [8 8], dct_fun);

% 收集所有系数 (除了DC系数，因为它通常很大)
B_no_dc = B;
% 将每个块的DC系数(左上角)设为0，以便更好地观察AC系数的分布
B_no_dc(1:8:end, 1:8:end) = 0;
all_coeffs = B_no_dc(:);

% 3. 绘制DCT系数的直方图
subplot(1,2,2);
histogram(all_coeffs, 50); % 使用histogram函数以获得更好的可视化
title('DCT交流(AC)系数直方图');
xlabel('系数幅值');
ylabel('数量');