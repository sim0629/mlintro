function XC = extract_features(X, centroids, rfSize, CIFAR_DIM, M,P,pooling,testing)
  numCentroids = size(centroids,1);
  
  % compute features for all training images
  XC = zeros(size(X,1), numCentroids*4);
  for i=1:size(X,1)
    if (mod(i,1000) == 0) fprintf('Extracting features: %d / %d\n', i, size(X,1)); end
    
    % extract overlapping sub-patches into rows of 'patches'
    patches = [ im2col(reshape(X(i,1:1024),CIFAR_DIM(1:2)), [rfSize rfSize]) ;
                im2col(reshape(X(i,1025:2048),CIFAR_DIM(1:2)), [rfSize rfSize]) ;
                im2col(reshape(X(i,2049:end),CIFAR_DIM(1:2)), [rfSize rfSize]) ]';

    % do preprocessing for each patch
    
    % normalize for contrast
    patches = bsxfun(@rdivide, bsxfun(@minus, patches, mean(patches,2)), sqrt(var(patches,[],2)+10));
    % whiten
    patches = bsxfun(@minus, patches, M) * P;
    
    % compute 'triangle' activation function
    xx = sum(patches.^2, 2);
    cc = sum(centroids.^2, 2)';
    xc = patches * centroids';
    
    z = sqrt( bsxfun(@plus, cc, bsxfun(@minus, xx, 2*xc)) ); % distances
    [v,inds] = min(z,[],2);
    mu = mean(z, 2); % average distance to centroids for each patch
    patches = max(bsxfun(@minus, mu, z), 0);
    % patches is now the data matrix of activations for each patch
    
    % reshape to numCentroids-channel image
    prows = CIFAR_DIM(1)-rfSize+1;
    pcols = CIFAR_DIM(2)-rfSize+1;
    patches = reshape(patches, prows, pcols, numCentroids);
    
    % pool over quadrants
    SUM_POOLING = 0;
    MAX_POOLING = 1;
    STOCH_POOLING = 2;
    STOCHMAX_POOLING = 3;
    AVG_POOLING = 4;
    if (pooling == SUM_POOLING)
      XCi = pooling_sum(patches, prows, pcols);
    elseif (pooling == MAX_POOLING)
      XCi = pooling_max(patches, prows, pcols);
    elseif (pooling == STOCH_POOLING)
      if (testing)
        XCi = pooling_stoch_test(patches, prows, pcols);
      else
        XCi = pooling_stoch_train(patches, prows, pcols);
      end
    elseif (pooling == STOCHMAX_POOLING)
      if (testing)
        XCi = pooling_stochmax_test(patches, prows, pcols);
      else
        XCi = pooling_stochmax_train(patches, prows, pcols);
      end
    elseif (pooling == AVG_POOLING)
      XCi = pooling_avg(patches, prows, pcols);
    end

    XC(i,:) = XCi;
  end

