function [training, testing] = load_data(path)
  data = load(path);
  training.images = data.trainingData.Images(:, 1 : 10000)';
  training.labels = data.trainingData.Labels(1 : 10000, :);
  testing.images = data.testingData.Images(:, 1 : 2000)';
  testing.labels = data.testingData.Labels(1 : 2000, :);
end
