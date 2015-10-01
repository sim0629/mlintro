% 2009-11744 심규민

datasetPath = "../data/MNIST_Dataset.mat";
[trainingData, testingData] = load_data(datasetPath);
hidden = compute_hidden(10, trainingData.Images, trainingData.Labels);
actual = one_of_n(trainingData.Labels);
param = pinv(hidden) * actual;
param
