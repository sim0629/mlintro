function [trainingData, testingData] = load_data(datasetPath)
  data = load(datasetPath);
  trainingData.Images = data.trainingData.Images(:,1:10000)';
  trainingData.Labels = data.trainingData.Labels(1:10000,:);
  testingData.Images = data.testingData.Images(:,1:2000)';
  testingData.Labels = data.testingData.Labels(1:2000,:);
end
