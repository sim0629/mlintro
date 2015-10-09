function [] = my_rbfn(K, etaM, etaV, EPOCH, novalid)
  start = tic;

  fprintf('K = %d, etaM = %.3f, etaV = %.3f, EPOCH = %d\n', K, etaM, etaV, EPOCH);

  path = '../data/MNIST_Dataset.mat';
  [training, validation, testing] = load_data(path, novalid);
  if K > 10
    labels = kmeans_gyumin(K, training.images, training.labels);
  else
    K = 10;
    labels = training.labels + 1;
  end
  kernel = make_kernel(K, training.images, labels);

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
end
