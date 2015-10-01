function [center, covar] = kernel_of(imgK)
  [N, D] = size(imgK);
  center = mean(imgK);
  covar = zeros(D, D);
  for i = 1:N
    diff = imgK(i,:) - center;
    covar += diff' * diff;
  end
  covar /= N;
end
