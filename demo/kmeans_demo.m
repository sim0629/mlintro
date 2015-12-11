function [] = kmeans_demo(pooling, tag, trainX, trainY, testX, testY, rfSize, numCentroids, numPatches, CIFAR_DIM, CIFAR_DIR)
SUM_POOLING = 0;
MAX_POOLING = 1;

fprintf('Start [%s]\n', tag);

tic;

% extract random patches
patches = zeros(numPatches, rfSize*rfSize*3);
for i=1:numPatches
  if (mod(i,10000) == 0) fprintf('Extracting patch: %d / %d\n', i, numPatches); end
  
  r = random('unid', CIFAR_DIM(1) - rfSize + 1);
  c = random('unid', CIFAR_DIM(2) - rfSize + 1);
  patch = reshape(trainX(mod(i-1,size(trainX,1))+1, :), CIFAR_DIM);
  patch = patch(r:r+rfSize-1,c:c+rfSize-1,:);
  patches(i,:) = patch(:)';
end

% normalize for contrast
patches = bsxfun(@rdivide, bsxfun(@minus, patches, mean(patches,2)), sqrt(var(patches,[],2)+10));

% whiten
C = cov(patches);
M = mean(patches);
[V,D] = eig(C);
P = V * diag(sqrt(1./(diag(D) + 0.1))) * V';
patches = bsxfun(@minus, patches, M) * P;

% run K-means
centroids = run_kmeans(patches, numCentroids, 50);
centroids_image = show_centroids(centroids, rfSize);
imwrite(centroids_image, strcat(CIFAR_DIR, 'out/', tag, '.png'));

% extract training features
if (pooling == SUM_POOLING)
  trainXC = extract_features_sum(trainX, centroids, rfSize, CIFAR_DIM, M,P);
elseif (pooling == MAX_POOLING)
  trainXC = extract_features_max(trainX, centroids, rfSize, CIFAR_DIM, M,P);
end

% standardize data
trainXC_mean = mean(trainXC);
trainXC_sd = sqrt(var(trainXC)+0.01);
trainXCs = bsxfun(@rdivide, bsxfun(@minus, trainXC, trainXC_mean), trainXC_sd);
trainXCs = [trainXCs, ones(size(trainXCs,1),1)];

% train classifier using SVM
C = 100;
theta = train_svm(trainXCs, trainY, C);

[val,labels] = max(trainXCs*theta, [], 2);
fprintf('Train accuracy %f%%\n', 100 * (1 - sum(labels ~= trainY) / length(trainY)));

%%%%% TESTING %%%%%

% compute testing features and standardize
if (pooling == SUM_POOLING)
  testXC = extract_features_sum(testX, centroids, rfSize, CIFAR_DIM, M,P);
elseif (pooling == MAX_POOLING)
  testXC = extract_features_max(testX, centroids, rfSize, CIFAR_DIM, M,P);
end
testXCs = bsxfun(@rdivide, bsxfun(@minus, testXC, trainXC_mean), trainXC_sd);
testXCs = [testXCs, ones(size(testXCs,1),1)];

% test and print result
[val,labels] = max(testXCs*theta, [], 2);
fprintf('Test accuracy %f%%\n', 100 * (1 - sum(labels ~= testY) / length(testY)));

toc;

end