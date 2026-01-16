
% 复现DCT基图像 
N = 8;
basis_images = zeros(N*N, N, N);
I = zeros(N, N);
figure('Name', 'DCT Basis Images (8x8)');
colormap(gray);

count = 1;
for u = 0:N-1
    for v = 0:N-1
        temp_I = I;
        temp_I(u+1, v+1) = 255; % 将单个系数设置为非零
        basis_image = idct2(temp_I);

        subplot(N, N, count);
        imshow(basis_image, []);
        title(sprintf('u=%d, v=%d', u, v));
        axis off;

        count = count + 1;
    end
end