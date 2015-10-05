function [] = draw_kernel_image(kernel)
  [K, D] = size(kernel.means);
  d = sqrt(D);
  kernelImage = zeros(d, d * K);
  for k = 1 : K
    kernelImageK = reshape(kernel.means(k, :), d, d);
    kernelImage(:, (k - 1) * d + 1 : k * d) = kernelImageK;
  end
  figure;
  imshow(mat2gray(kernelImage));
  drawnow;
end
