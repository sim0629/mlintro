function [out] = n_of_max(in)
  [~, I] = max(in, [], 2);
  out = I - 1;
end
