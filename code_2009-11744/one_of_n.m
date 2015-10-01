function [out] = one_of_n(in)
  N = length(in);
  out = zeros(N, 10);
  for i = 1:N
    out(i, in(i) + 1) = 1;
  end
end
