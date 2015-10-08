% 2009-11744 Gyumin Sim

start = tic;

K = 2000;
etaM = 0.1;
etaV = 0.1;
EPOCH = 1;
novalid = false;

fprintf('K = %d, etaM = %.3f, etaV = %.3f, EPOCH = %d\n', K, etaM, etaV, EPOCH);

path = '../data/MNIST_Dataset.mat';
[training, validation, testing] = load_data(path, novalid);
kernel = make_kernel(K, training.images, training.labels);

prev = toc(start);

for epoch = 1 : EPOCH
  hidden = compute_hidden(kernel, training.images);
  params = fit_parameter(hidden, training.labels);

  if novalid
    successV = 0;
  else
    resultsV = guess(params, kernel, validation.images);
    successV = success_rate(resultsV, validation.labels);
  end

  results = guess(params, kernel, training.images);
  success = success_rate(results, training.labels);

  now = toc(start);
  fprintf('[%03d] validation = %.2f%%, training = %.2f%%, elapsed = %.1fs\n', epoch, successV * 100, success * 100, now);
  if now + 2 * (now - prev) > 600
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
