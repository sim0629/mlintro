function [center, mvar] = kernel_of(imgK)
  center = mean(imgK);
  mvar = mean(var(imgK));
end
