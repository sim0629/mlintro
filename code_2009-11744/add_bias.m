function [out] = add_bias(in)
  [R, ~] = size(in);
  bias = ones(R, 1);
  out = [bias in];
end
