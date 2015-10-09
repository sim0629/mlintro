function [training, validation, testing] = load_data(path, novalid)
  data = load(path);
  if novalid
    training.images = data.trainingData.Images(:, 1 : 10000)';
    training.labels = data.trainingData.Labels(1 : 10000, :);
    validation = [];
  else
    training.images = data.trainingData.Images(:, 1 : 8000)';
    training.labels = data.trainingData.Labels(1 : 8000, :);
    validation.images = data.trainingData.Images(:, 8001 : 10000)';
    validation.labels = data.trainingData.Labels(8001 : 10000, :);
  end
  testing.images = data.testingData.Images(:, 1 : 2000)';
  testing.labels = data.testingData.Labels(1 : 2000, :);
end
