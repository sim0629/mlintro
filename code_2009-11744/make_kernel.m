function [kernel] = make_kernel(images, labels)
  [N, D] = size(images);
  K = 10;
  kernel.means = zeros(K, D);
  kernel.vars = zeros(K, 1);
  for k = 1 : K
    imagesK = instance_of(k - 1, images, labels);
    meanK = mean(imagesK);
    diffK = bsxfun(@minus, imagesK, meanK);
    varK = mean(sum(diffK .^ 2, 2));
    kernel.means(k, :) = meanK;
    kernel.vars(k) = varK;
  end
end
