% 2009-11744 심규민

start = tic;

path = "../data/MNIST_Dataset.mat";
[training, testing] = load_data(path);
kernel = make_kernel(training.images, training.labels);

etaM = 0.3;
etaV = 0.1;

fprintf("etaM = %.3f, etaV = %.3f\n", etaM, etaV);

for epoch = 1 : 999
  hidden = compute_hidden(kernel, training.images);
  params = fit_parameter(hidden, training.labels);

  results = guess(params, kernel, testing.images);
  testingSuc = success_rate(results, testing.labels);

  results = guess(params, kernel, training.images);
  trainingSuc = success_rate(results, training.labels);

  now = toc(start);
  fprintf("[%03d] testingSuc = %.3f%%, trainingSuc = %.3f%%, elapsed = %.1fs\n", epoch, testingSuc * 100, trainingSuc * 100, now);

  delta = get_delta(etaM, etaV, results, params, hidden, kernel, training.images, training.labels);
  kernel.means += delta.means;
  kernel.vars += delta.vars;
end
