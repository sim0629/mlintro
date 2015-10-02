% 2009-11744 심규민

path = "../data/MNIST_Dataset.mat";
[training, testing] = load_data(path);
kernel = make_kernel(training.images, training.labels);
hidden = compute_hidden(kernel, training.images);
params = fit_parameter(hidden, training.labels);
results = guess(params, kernel, testing.images);
output = n_of_max(results)
