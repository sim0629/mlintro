function [delta] = get_delta(etaM, etaV, results, params, hidden, kernel, images, labels)
  y = one_of_n(labels);
  w = reset_bias(params);
  common = ((y - results) * w') .* hidden;

  K = length(kernel.vars);
  [~, D] = size(images);
  means = zeros(K, D);
  vars = zeros(K, 1);

  for k = 1 : K
    meanK = kernel.means(k, :);
    varK = kernel.vars(k);
    diffK = bsxfun(@minus, images, meanK);
    dmeanK = diffK ./ varK;
    dvarK = sum(diffK .^ 2, 2) ./ (varK ^ 1.5);
    commonK = common(:, k);
    means(k, :) = sum(bsxfun(@times, commonK, dmeanK));
    vars(k, :) = sum(common(:, k) .* dvarK);
  end

  delta.means = etaM * means;
  delta.vars = etaV * vars;
end
