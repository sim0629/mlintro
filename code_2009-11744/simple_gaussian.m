function [success] = simple_gaussian(kernel, images, labels)
  [~, D] = size(kernel);
  params = eye(D);
  hidden = compute_hidden(kernel, images);
  results = hidden * params;
  success = success_rate(results, labels);
end
