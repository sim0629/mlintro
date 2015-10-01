function [hidden] = compute_hidden(K, img, label)
  [N, D] = size(img);
  hidden = ones(N, K);
  for k = 1:K
    imgK = instance_of(k - 1, img, label);
    [centerK, mvarK] = kernel_of(imgK);
    for n = 1:N
      diff = img(n,:) - centerK;
      mult = -0.5 * diff * diff' / 10;
      hidden(n, k) = exp(mult);
    end
  end
end
