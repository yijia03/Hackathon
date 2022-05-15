load('emnist-balanced.mat');

X = dataset.train.images; X = double(X);
y = dataset.train.labels; y = double(y); y = y + 1;		% because EMNIST labels start at 0 and MATLAB matricies start at 1
testX = dataset.test.images; testX = double(testX);
testY = dataset.test.labels; testY = double(testY); testY = testY + 1;

clear dataset;

save('processed_data.mat');

% Debug, print data to .txt
save ('Debug\fullData.txt');
save Debug\trainX.txt X;
save Debug\trainY.txt y;
save Debug\testX.txt testX;
save Debug\testY.txt testY;