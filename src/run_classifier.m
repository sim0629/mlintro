%% Constants
SUM_POOLING = 0;
MAX_POOLING = 1;
STOCH_POOLING = 2;
STOCHMAX_POOLING = 3;
AVG_POOLING = 4;

CIFAR_DIR='../cifar-10-batches-mat/';

assert(~strcmp(CIFAR_DIR, '/path/to/cifar/cifar-10-batches-mat/'), ...
       ['You need to modify kmeans_demo.m so that CIFAR_DIR points to ' ...
        'your cifar-10-batches-mat directory.  You can download this ' ...
        'data from:  http://www.cs.toronto.edu/~kriz/cifar-10-matlab.tar.gz']);

%% Configuration
addpath minFunc;
rfSize = 6;
numCentroids=1600;
numPatches = 400000;
CIFAR_DIM=[32 32 3];

%% Load CIFAR training data
fprintf('Loading training data...\n');
f1=load([CIFAR_DIR 'data_batch_1.mat']);
f2=load([CIFAR_DIR 'data_batch_2.mat']);
f3=load([CIFAR_DIR 'data_batch_3.mat']);
f4=load([CIFAR_DIR 'data_batch_4.mat']);
f5=load([CIFAR_DIR 'data_batch_5.mat']);

trainX = double([f1.data; f2.data; f3.data; f4.data; f5.data]);
trainY = double([f1.labels; f2.labels; f3.labels; f4.labels; f5.labels]) + 1; % add 1 to labels!
clear f1 f2 f3 f4 f5;

%% Load CIFAR test data
fprintf('Loading test data...\n');
f1=load([CIFAR_DIR 'test_batch.mat']);
testX = double(f1.data);
testY = double(f1.labels) + 1;
clear f1;

%% Run
for i = 0:2
  kmeans_demo(STOCHMAX_POOLING, strcat('stochmax', int2str(i)), ...
              trainX, trainY, testX, testY, ...
              rfSize, numCentroids, numPatches, CIFAR_DIM, CIFAR_DIR);
  kmeans_demo(STOCH_POOLING, strcat('stoch', int2str(i)), ...
              trainX, trainY, testX, testY, ...
              rfSize, numCentroids, numPatches, CIFAR_DIM, CIFAR_DIR);
  kmeans_demo(AVG_POOLING, strcat('avg', int2str(i)), ...
              trainX, trainY, testX, testY, ...
              rfSize, numCentroids, numPatches, CIFAR_DIM, CIFAR_DIR);
end
%for i = 0:9
%  kmeans_demo(SUM_POOLING, strcat('sum', int2str(i)), ...
%              trainX, trainY, testX, testY, ...
%              rfSize, numCentroids, numPatches, CIFAR_DIM, CIFAR_DIR);
%end
%for i = 0:9
%  kmeans_demo(MAX_POOLING, strcat('max', int2str(i)), ...
%              trainX, trainY, testX, testY, ...
%              rfSize, numCentroids, numPatches, CIFAR_DIM, CIFAR_DIR);
%end
