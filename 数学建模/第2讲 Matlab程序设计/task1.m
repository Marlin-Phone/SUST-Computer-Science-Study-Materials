% 1. 生成指定均值的随机矩阵
rng('shuffle'); % 使用当前时间作为随机数种子，确保每次运行结果不同
temp_D = 10 * rand(5, 5); % 生成 [0, 10] 范围内的 5x5 随机矩阵
current_mean = mean(temp_D(:)); % 计算当前矩阵的均值
D = temp_D - current_mean + 5; % 调整矩阵使整体均值为5
% 确保调整后的值仍在[0, 10]附近，对于严格范围可以进行裁剪
D(D > 10) = 10;
D(D < 0) = 0;

% 提取对角线元素
diag_elements = diag(D);

% 构成新的对角矩阵A
A = diag(diag_elements);

% 输出结果
disp('问题1结果：');
disp('生成的均值为5的随机矩阵 D:');
disp(D);
disp('矩阵D的实际均值:');
disp(mean(D(:)));
disp('提取对角线元素构成的对角矩阵 A:');
disp(A);