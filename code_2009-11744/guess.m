function [results] = guess(params, kernel, images)
  hidden = compute_hidden(kernel, images);
  h = add_bias(hidden);
  results = h * params;
end
