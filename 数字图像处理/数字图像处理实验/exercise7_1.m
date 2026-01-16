%  dct2 和 idct2 示例  
I = imread('cameraman.tif');
I_block = I(121:128, 185:192); % 取一个8x8的图像块
I_block_double = im2double(I_block);

J = dct2(I_block_double); % 对8x8块进行DCT变换
K = idct2(J);             % 进行逆DCT变换

figure;
subplot(1,3,1); imshow(I_block); title('原始8x8块');
subplot(1,3,2); imshow(J); title('DCT系数'); % 注意：直接显示系数意义不大
text(1, 1, sprintf('%.1f', J(1,1)), 'Color', 'white'); % 显示直流分量
subplot(1,3,3); imshow(K); title('重构后的块');
% J中的能量集中在左上角(1,1)位置，即直流(DC)分量。
% 重构后的图像K与原始块I_block_double几乎完全相同。

%  wcompress 示例  
I_color = imread('peppers.png'); % wcompress可以处理彩色图

% 压缩
% 'c'表示压缩, I_color是输入图像, 'out.wtc'是输出文件
% 'sqtwolog'是压缩方法, 'wname','sym4'表示使用sym4小波
[cr, bpp] = wcompress('c', I_color, 'out.wtc', 'sqtwolog', 'wname', 'sym4');
fprintf('压缩完成. 压缩率: %.2f, 每像素比特数: %.2f\n', cr, bpp);

% 解压缩
% 'u'表示解压缩
Xc = wcompress('u', 'out.wtc');

% 显示结果
figure;
subplot(1,2,1); imshow(I_color); title('原始图像');
subplot(1,2,2); imshow(Xc); title('小波压缩后图像');
delete('out.wtc'); % 删除临时文件