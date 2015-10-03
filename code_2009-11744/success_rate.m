function [success] = success_rate(results, labels)
  output = n_of_max(results);
  success = mean(labels == output);
end
