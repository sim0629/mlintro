function [params] = fit_parameter(hidden, labels)
  h = add_bias(hidden);
  y = one_of_n(labels);
  params = pinv(h) * y;
end
