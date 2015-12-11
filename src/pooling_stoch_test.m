function XCi = pooling_stoch_test(patches, prows, pcols)
  function q = for_quad(sub)
    bj = sum(sum(sub .^ 2, 1), 2);
    bm = sum(sum(sub, 1), 2);
    q = bj ./ bm;
    q(isnan(q)) = 0;
  end
  halfr = round(prows/2);
  halfc = round(pcols/2);
  q1 = for_quad(patches(1:halfr, 1:halfc, :));
  q2 = for_quad(patches(halfr+1:end, 1:halfc, :));
  q3 = for_quad(patches(1:halfr, halfc+1:end, :));
  q4 = for_quad(patches(halfr+1:end, halfc+1:end, :));
  XCi = [q1(:);q2(:);q3(:);q4(:)]';
end
