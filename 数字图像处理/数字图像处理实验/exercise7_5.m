% 读取图像 
I = imread('cameraman.tif');
[rows, cols] = size(I);

% 创建一个图形窗口来显示所有位平面
figure;
sgtitle('8个位平面的分解'); % Super title

% 循环提取并显示每个位平面
for i = 1:8
    % 使用 bitget 获取第 i 位
    bit_plane = bitget(I, i);

    % 将二值图像 (0,1) 转换为可显示的 (0,255)
    display_plane = uint8(bit_plane) * 255;

    subplot(2, 4, i);
    imshow(display_plane);
    title(sprintf('第 %d 位平面', i));
end