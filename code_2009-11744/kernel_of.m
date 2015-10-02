function [center, mvar] = kernel_of(imagesK)
  center = mean(imagesK);
  mvar = mean(var(imagesK));
end
