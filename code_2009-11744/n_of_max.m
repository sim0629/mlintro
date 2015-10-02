function [out] = n_of_max(in)
  [M, I] = max(in, [], 2)
  out = I .- 1
end
