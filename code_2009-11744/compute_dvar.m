function [dvar] = compute_dvar(kernel, images)
  K = length(kernel.vars);
  [N, D] = size(images);
  dvar = zeros(N, K);
  for k = 1 : K
    meanK = kernel.means(k, :);
    varK = kernel.vars(k);
    diffK = bsxfun(@minus, images, meanK);
    dvar(:, k) = sum(diffK .^ 2, 2) ./ (varK ^ 1.5);
  end
end
