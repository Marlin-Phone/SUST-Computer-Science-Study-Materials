% EZW 零树根寻找概念演示 

% 1. 对图像进行小波变换
img = imread('cameraman.tif');
img_double = im2double(img(1:64, 1:64)); % 取一个64x64的小块以简化
level = 3;
[C, S] = wavedec2(img_double, level, 'bior4.4');

% 2. 将系数向量C重构成更直观的矩阵形式
[H1,V1,D1] = detcoef2('all', C, S, 1); % 第1层细节
[H2,V2,D2] = detcoef2('all', C, S, 2); % 第2层细节
[H3,V3,D3] = detcoef2('all', C, S, 3); % 第3层细节
A3 = appcoef2(C, S, 'bior4.4', level); % 第3层近似

% 3. 设置阈值并寻找零树根 (以第3层为例)
T = 0.1;
% 假设我们检查A3中的一个系数，看它是否为零树根
% A3[i,j] 的子节点是 H3[i,j], V3[i,j], D3[i,j]
% H3[i,j] 的子节点是 H2[2i-1:2i, 2j-1:2j], ...以此类推

% 检查A3(4,5)是否为零树根
i = 4; j = 5;
is_zerotree = true;

% 检查自身
if abs(A3(i,j)) >= T, is_zerotree = false; end

% 检查第3层子孙
if any(abs([H3(i,j), V3(i,j), D3(i,j)]) >= T), is_zerotree = false; end

% 检查第2层子孙
i2=2*i-1:2*i; j2=2*j-1:2*j;
if any(abs([H2(i2,j2); V2(i2,j2); D2(i2,j2)]) >= T, 'all'), is_zerotree = false; end

% 检查第1层子孙
i1=2*i2(1)-1:2*i2(2); j1=2*j2(1)-1:2*j2(2);
if any(abs([H1(i1,j1); V1(i1,j1); D1(i1,j1)]) >= T, 'all'), is_zerotree = false; end

if is_zerotree
    fprintf('在阈值T=%.1f下, A3(%d,%d) 是一个零树根 (ZTR)。\n', T, i, j);
else
    fprintf('在阈值T=%.1f下, A3(%d,%d) 不是一个零树根。\n', T, i, j);
end