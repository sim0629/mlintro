function [hidden] = compute_hidden(K, images, labels)
  [N, D] = size(images);
  hidden = ones(N, K);
  for k = 1 : K
    imagesK = instance_of(k - 1, images, labels);
    [centerK, mvarK] = kernel_of(imagesK);
    for n = 1 : N
      diff = images(n, :) - centerK;
      mult = -0.5 * diff * diff' / 10;
      hidden(n, k) = exp(mult);
    end
  end
end
