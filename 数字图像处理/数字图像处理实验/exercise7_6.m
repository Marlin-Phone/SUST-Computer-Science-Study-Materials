% 定义一个函数来处理单个块 
function [reconstructed_block, error_val] = process_dct_block(original_block, k)
    % 1. DCT变换
    dct_block = dct2(original_block);

    % 2. 保留最大的k个系数
    coeffs = abs(dct_block(:)); % 取绝对值
    [~, sorted_indices] = sort(coeffs, 'descend');

    % 创建一个零矩阵
    kept_coeffs_block = zeros(size(dct_block));
    % 将最大的k个系数放回
    kept_coeffs_block(sorted_indices(1:k)) = dct_block(sorted_indices(1:k));

    % 3. 逆DCT重构
    reconstructed_block = idct2(kept_coeffs_block);

    % 4. 计算误差
    error_val = sum((original_block(:) - reconstructed_block(:)).^2);
end

% 主脚本 
% 读取图像
img = im2double(imread('cameraman.tif'));

% 设置不同的k值
k_values = [2, 5, 10, 20];

figure;
num_k = length(k_values);

for i = 1:num_k
    k = k_values(i);

    % 使用blockproc处理整个图像 - 只获取重构图像
    fun = @(block_struct) process_dct_block(block_struct.data, k);
    reconstructed_img = blockproc(img, [8 8], fun);
    
    % 正确计算总误差
    total_error = sum(sum((img - reconstructed_img).^2));
    
    % 计算总的RMSE
    rmse = sqrt(total_error / numel(img));

    % 计算并显示残差图像
    residual_img = abs(img - reconstructed_img);

    % 显示重构图像 - 确保图像数据在有效范围内
    subplot(3, num_k, i);
    imshow(mat2gray(reconstructed_img)); % 使用mat2gray规范化数据范围
    title(sprintf('k = %d, RMSE = %.4f', k, rmse));

    % 显示残差图像
    subplot(3, num_k, i + num_k);
    imshow(mat2gray(residual_img)); % 使用mat2gray规范化数据范围
    title('残差图像');
end

% 显示原始图像作为对比
subplot(3, num_k, 2*num_k + 1);
imshow(img);
title('原始图像');