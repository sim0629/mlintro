function XCi = pooling_stochmax_test(patches, prows, pcols)
  function q = for_quad(sub)
    [r, c, z] = size(sub);
    prob = zeros(1, r * c);
    prob(1) = 1/2; prob(2) = 1/4; prob(3) = 1/8;
    sub = reshape(sub, 1, r * c, z);
    sorted = sort(sub, 'descend');
    q = sum(bsxfun(@times, sorted, prob));
  end
  halfr = round(prows/2);
  halfc = round(pcols/2);
  q1 = for_quad(patches(1:halfr, 1:halfc, :));
  q2 = for_quad(patches(halfr+1:end, 1:halfc, :));
  q3 = for_quad(patches(1:halfr, halfc+1:end, :));
  q4 = for_quad(patches(halfr+1:end, halfc+1:end, :));
  XCi = [q1(:);q2(:);q3(:);q4(:)]';
end
