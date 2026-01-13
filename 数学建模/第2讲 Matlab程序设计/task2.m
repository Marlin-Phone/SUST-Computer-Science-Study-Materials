% 2. 计算特定元素的平方根之和
% 创建一个含1000个元素的数组
vec = 1:1000;

% 初始化和
total_sum_sqrt = 0;

% 使用循环语句计算
for i = 1:length(vec)
    if vec(i) > 500
        total_sum_sqrt = total_sum_sqrt + sqrt(vec(i));
    end
end

% 输出结果
disp('问题2结果：');
disp('大于大于500的元素的平方根的和为:');
disp(total_sum_sqrt);

% 验证 (不使用循环)
% total_sum_sqrt_vec = sum(sqrt(vec(vec > 500)));
% fprintf('向量化计算验证结果为: %.4f\n', total_sum_sqrt_vec);