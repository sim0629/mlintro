function [matrix] = confusion_matrix(actual, predicted)
  matrix = zeros(10);
  l = length(actual);
  for i = 1:l
    matrix(actual(i), predicted(i)) = matrix(actual(i), predicted(i)) + 1;
  end
end
