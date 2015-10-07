function [labels] = kmeans_gyumin(K, images, labels)
  samples = images(1 : K, :);
  [N, ~] = size(images);
  distances = zeros(N, K);
  for k = 1 : K
    sample = samples(k, :);
    diff = bsxfun(@minus, images, sample);
    distances(:, k) = sum(diff .^ 2, 2);
  end
  [~, labels] = min(distances, [], 2);
end
