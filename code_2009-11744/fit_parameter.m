function [params] = fit_parameter(hidden, labels)
  [N, D] = size(hidden);
  bias = ones(N, 1);
  h = [bias hidden];
  y = one_of_n(labels);
  params = pinv(h) * y;
end
