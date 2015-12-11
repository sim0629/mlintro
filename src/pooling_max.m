function XCi = pooling_max(patches, prows, pcols)
  halfr = round(prows/2);
  halfc = round(pcols/2);
  q1 = max(max(patches(1:halfr, 1:halfc, :)),[],2);
  q2 = max(max(patches(halfr+1:end, 1:halfc, :)),[],2);
  q3 = max(max(patches(1:halfr, halfc+1:end, :)),[],2);
  q4 = max(max(patches(halfr+1:end, halfc+1:end, :)),[],2);
  XCi = [q1(:);q2(:);q3(:);q4(:)]';
end
