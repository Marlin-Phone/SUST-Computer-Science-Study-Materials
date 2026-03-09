% 数据
data = [
    100, 0.112, 0.14, 0.653, 29.497, 0.455, 0.213, 0.095, 0.165;
    1000, 0.191, 0.391, 1.791, 30.954, 3.037, 5.304, 0.566, 4.82;
    5000, 1.07, 2.629, 7.375, 39.967, 16.06, 161.654, 14.346, 175.533;
    10000, 2, 5, 18, 43, 31, 687, 65, 737;
    50000, 7, 25, 70, 83, 117, 8274, 1154, 15198;
    100000, 16, 57, 135, 124, 233, 22379, 4334, 60698;
    1000000, 232, 1447, 1724, 514, 2557, NaN, NaN, NaN;
    5000000, 1285, 4611, 7508, 1934, 13111, NaN, NaN, NaN;
    10000000, 2437, 6944, 14088, 4023, 26294, NaN, NaN, NaN
];

% 数据规模
data_size = data(:, 1);

% 各算法的排序消耗时间
quick_sort = data(:, 2);
heap_sort = data(:, 3);
radix_sort = data(:, 4);
bucket_sort = data(:, 5);
merge_sort = data(:, 6);
selection_sort = data(:, 7);
insertion_sort = data(:, 8);
bubble_sort = data(:, 9);

% 绘制折线图
figure;
plot(data_size, quick_sort, '-o', 'DisplayName', '快速排序');
hold on;
plot(data_size, heap_sort, '-x', 'DisplayName', '堆排序');
plot(data_size, radix_sort, '-s', 'DisplayName', '基数排序');
plot(data_size, bucket_sort, '-d', 'DisplayName', '桶排序');
plot(data_size, merge_sort, '-^', 'DisplayName', '归并排序');
plot(data_size, selection_sort, '-v', 'DisplayName', '选择排序');
plot(data_size, insertion_sort, '-<', 'DisplayName', '插入排序');
plot(data_size, bubble_sort, '->', 'DisplayName', '冒泡排序');
hold off;

% 设置图例和标签
legend('show');
xlabel('数据规模');
ylabel('排序消耗时间 (ms)');
title('各算法的排序消耗时间');
grid on;

% 设置横纵坐标为非固定
set(gca, 'XScale', 'log'); % 横坐标对数刻度
set(gca, 'YScale', 'log'); % 纵坐标对数刻度
