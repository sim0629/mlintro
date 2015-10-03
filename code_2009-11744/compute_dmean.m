function [dmean] = compute_dmean(kernel, images)
  K = length(kernel.vars);
  [N, D] = size(images);
  dmean = zeros(N, D, K);
  for k = 1 : K
    meanK = kernel.means(k, :);
    varK = kernel.vars(k);
    diffK = bsxfun(@minus, images, meanK);
    dmean(:, :, k) = diffK ./ varK;
  end
end
