% 2009-11744 심규민

path = "../data/MNIST_Dataset.mat";
[training, testing] = load_data(path);
kernel = make_kernel(training.images, training.labels);

while true
  hidden = compute_hidden(kernel, training.images);
  params = fit_parameter(hidden, training.labels);

  results = guess(params, kernel, testing.images);
  success = success_rate(results, testing.labels)

  results = guess(params, kernel, training.images);
  delta = get_delta(results, params, hidden, kernel, training.images, training.labels);
  kernel.means += delta.means;
  kernel.vars += delta.vars;
end
