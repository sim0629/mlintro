function [hidden] = compute_hidden(kernel, images)
  K = length(kernel.vars);
  [N, D] = size(images);
  hidden = zeros(N, K);
  for k = 1 : K
    meanK = kernel.means(k, :);
    varK = kernel.vars(k);
    diffK = bsxfun(@minus, images, meanK);
    hidden(:, k) = exp(sum(diffK .^ 2, 2) ./ varK .* -0.5);
  end
end
