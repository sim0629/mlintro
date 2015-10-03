function [delta] = get_delta(results, params, hidden, kernel, images, labels)
  y = one_of_n(labels);
  w = reset_bias(params);
  common = ((y .- results) * w') .* hidden;
  eta = 0.1;

  dmean = compute_dmean(kernel, images);
  [N, D, K] = size(dmean);
  common3d = reshape(common, N, 1, K);
  means = eta * reshape(sum(bsxfun(@times, common3d, dmean)), D, K);

  dvar = compute_dvar(kernel, images);
  vars = eta * sum(common .* dvar);

  delta.means = means';
  delta.vars = vars';
end
