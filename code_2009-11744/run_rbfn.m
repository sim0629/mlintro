% 2009-11744 Gyumin Sim

start = tic;

K = 30;
etaM = 0.03;
etaV = 0.1;
fprintf('K = %d, etaM = %.2f, etaV = %.2f\n', K, etaM, etaV);

path = '../data/MNIST_Dataset.mat';
[training, testing] = load_data(path);
kernel = make_kernel(30, training.images, training.labels);
success = simple_gaussian(kernel, testing.images, testing.labels);
fprintf('simple gaussian success = %.2f%%\n', success * 100);

prev = toc(start);

EPOCH = 999;
for epoch = 1 : EPOCH
  hidden = compute_hidden(kernel, training.images);
  params = fit_parameter(hidden, training.labels);

  results = guess(params, kernel, training.images);
  success = success_rate(results, training.labels);

  now = toc(start);
  fprintf('[%03d] success = %.2f%%, elapsed = %.1fs\n', epoch, success * 100, now);
  if now + (now - prev) > 555
    break;
  end
  prev = now;

  if epoch == EPOCH
    break;
  end

  delta = get_delta(etaM, etaV, results, params, hidden, kernel, training.images, training.labels);
  kernel.means = kernel.means + delta.means;
  kernel.vars = kernel.vars + delta.vars;
end

results = guess(params, kernel, testing.images);
success = success_rate(results, testing.labels);
fprintf('success = %.2f%%\n', success * 100);
save_result(results);
