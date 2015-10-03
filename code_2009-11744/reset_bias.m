function [out] = reset_bias(in)
  [R, C] = size(in);
  out = in(2 : R, :);
end
