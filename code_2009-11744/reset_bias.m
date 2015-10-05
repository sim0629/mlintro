function [out] = reset_bias(in)
  [R, ~] = size(in);
  out = in(2 : R, :);
end
