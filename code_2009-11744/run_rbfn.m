% 2009-11744 심규민

path = "../data/MNIST_Dataset.mat";
[training, testing] = load_data(path);
kernel = make_kernel(training.images, training.labels);
