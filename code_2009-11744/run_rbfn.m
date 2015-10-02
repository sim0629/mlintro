% 2009-11744 심규민

path = "../data/MNIST_Dataset.mat";
[training, testing] = load_data(path);
hidden = compute_hidden(10, training.images, training.labels);
actual = one_of_n(training.labels);
param = pinv(hidden) * actual;
param
