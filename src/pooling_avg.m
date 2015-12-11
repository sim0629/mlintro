function XCi = pooling_avg(patches, prows, pcols)
  halfr = round(prows/2);
  halfc = round(pcols/2);
  q1 = sum(sum(patches(1:halfr, 1:halfc, :), 1),2) / (halfr * halfc);
  q2 = sum(sum(patches(halfr+1:end, 1:halfc, :), 1),2) / ((prows - halfr) * halfc);
  q3 = sum(sum(patches(1:halfr, halfc+1:end, :), 1),2) / (halfr * (pcols - halfc));
  q4 = sum(sum(patches(halfr+1:end, halfc+1:end, :), 1),2) / ((prows - halfr) * (pcols - halfc));
  XCi = [q1(:);q2(:);q3(:);q4(:)]';
end
