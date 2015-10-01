function [imgK] = instance_of(k, img, label)
  N = length(label);
  imgK = [];
  for i = 1:N
    if label(i) == k
      imgK = [imgK; img(i,:)];
    end
  end
end
