function XCi = pooling_stoch_train(patches, prows, pcols)
  function q = for_quad(sub)
    [r, c, z] = size(sub);
    sub = reshape(sub, 1, r * c, z);
    sub_sum = sum(sub);
    sub_prob = bsxfun(@rdivide, sub, sub_sum);
    sub_prob = [zeros(1, 1, z) cumsum(sub_prob)];
    q = zeros(1, 1, z);
    for i = 1:z
      idx = sum(rand >= sub_prob(:, :, i));
      q(:, :, i) = sub(1, idx, i);
    end
  end
  halfr = round(prows/2);
  halfc = round(pcols/2);
  q1 = for_quad(patches(1:halfr, 1:halfc, :));
  q2 = for_quad(patches(halfr+1:end, 1:halfc, :));
  q3 = for_quad(patches(1:halfr, halfc+1:end, :));
  q4 = for_quad(patches(halfr+1:end, halfc+1:end, :));
  XCi = [q1(:);q2(:);q3(:);q4(:)]';
end
