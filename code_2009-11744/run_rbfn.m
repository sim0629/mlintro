% 2009-11744 심규민

start = tic;

path = "../data/MNIST_Dataset.mat";
[training, testing] = load_data(path);
kernel = make_kernel(training.images, training.labels);

etaM = 0.3;
etaV = 0.1;

fprintf("etaM = %.3f, etaV = %.3f\n", etaM, etaV);

EPOCH = 90
for epoch = 1 : EPOCH
  hidden = compute_hidden(kernel, training.images);
  params = fit_parameter(hidden, training.labels);

  results = guess(params, kernel, training.images);
  success = success_rate(results, training.labels);

  now = toc(start);
  fprintf("[%03d] success = %.3f%%, elapsed = %.1fs\n", epoch, success * 100, now);

  if epoch == EPOCH
    break
  end

  delta = get_delta(etaM, etaV, results, params, hidden, kernel, training.images, training.labels);
  kernel.means += delta.means;
  kernel.vars += delta.vars;
end

results = guess(params, kernel, testing.images);
success = success_rate(results, testing.labels);
fprintf("success = %.3f%%\n", success * 100);
save_result(results);
