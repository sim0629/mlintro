% 2009-11744 Gyumin Sim

start = tic;

if length(argv()) == 0
  K = 10;
  etaM = 0.01;
  etaV = 0.1;
else
  K = str2num(argv(){1});
  etaM = str2num(argv(){2});
  etaV = str2num(argv(){3});
end

fprintf('K = %d, etaM = %.3f, etaV = %.3f\n', K, etaM, etaV);

path = '../data/MNIST_Dataset.mat';
[training, validation, testing] = load_data(path);
kernel = make_kernel(K, training.images, training.labels);

prev = toc(start);

EPOCH = 999;
for epoch = 1 : EPOCH
  hidden = compute_hidden(kernel, training.images);
  params = fit_parameter(hidden, training.labels);

  resultsV = guess(params, kernel, validation.images);
  successV = success_rate(resultsV, validation.labels);

  results = guess(params, kernel, training.images);
  success = success_rate(results, training.labels);

  now = toc(start);
  fprintf('[%03d] validation = %.2f%%, training = %.2f%%, elapsed = %.1fs\n', epoch, successV * 100, success * 100, now);
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
