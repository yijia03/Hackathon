% Used to create the shortened dataset for testing from the full one
m = 25000;
load('processed_data');

X = X(1:m,:);
y = y(1:m,:);

save('processed_data_short.mat');

% Debug, print data to .txt
save Debug\trainX_short.txt X;
save Debug\trainY_short.txt y;