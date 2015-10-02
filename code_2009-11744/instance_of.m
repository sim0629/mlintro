function [imagesK] = instance_of(k, images, labels)
  N = length(labels);
  imagesK = [];
  for i = 1:N
    if labels(i) == k
      imagesK = [imagesK; images(i,:)];
    end
  end
end
