close all; clc; clear; 
% clearvars -except X y testX testY;		% This might be useful, but delete 'clear' above it

%%%% Parameters %%%%
input_layer_size  = 784;  % 28x28 Greyscale Input Images
hidden_layer_size = 120;   % 80 hidden units in first hidden layer
hidden_layer_2_size = 80; % 80 hidden units in second hidden layer
num_labels = 47;          % 47 labels: 
						  % 	1-10 are digits 0-9, where label 1 is 0
                          % 	11-36 are uppercase letters, but they also represent lowercase letters with similar written form
						  % 	37-47 are lowercase letters which do not look the same as their uppcase form: a, b, d, e, f, g, h, n, q, r, t

%%%% Loading Training Data %%%%
% X is a matrix of m columns and 784 rows where m is the number of data points, the 28x28 image is unrolled into a single row
% y is a column vector containing the correct labels of each data point
fprintf('Loading Data\n');

load('Training_Data\processed_data_short_5000');	% 5000 training examples for training and another 5000 for testing
% load('Training_Data\processed_data_short');			% 25000 training examples for training but the full 18800 for testing
% load('Training_Data\processed_data');				% 112800 training examples and 18800 for testing from EMNIST (Balanced): https://arxiv.org/pdf/1702.05373v1.pdf

m = size(X, 1);	

% Display Data Points
sel = randperm(size(X, 1));
sel = sel(1:100);

displayData(X(sel, :));

%%%% Initializing Random Parameters %%%%
fprintf('Initializing\n');
initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, hidden_layer_2_size);
initial_Theta3 = randInitializeWeights(hidden_layer_2_size, num_labels);

initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:) ; initial_Theta3(:)];

%%%% Training Neural Net %%%%
fprintf('Training\n');
iterations = 10;
options = optimset('MaxIter', iterations);
lambda = 6;

% Cost Function Minimization
costFunction = @(p) nnCostFunction(p, input_layer_size, hidden_layer_size, hidden_layer_2_size, num_labels, X, y, lambda);				   
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

% Theta1 and Theta2 from nn_params
layer1 = hidden_layer_size * (input_layer_size + 1);
layer2 = layer1 + hidden_layer_2_size * (hidden_layer_size + 1);

Theta1 = reshape(nn_params(1 : layer1), hidden_layer_size, (input_layer_size + 1));
Theta2 = reshape(nn_params(layer1 + 1 : layer2), hidden_layer_2_size, (hidden_layer_size + 1));
Theta3 = reshape(nn_params(layer2 + 1 : end), num_labels, (hidden_layer_2_size + 1));

%%%% Prediction %%%%
pred = predict(Theta1, Theta2, Theta3, X);
accuracy_trained = mean(double(pred == y))
fprintf('\nTraining Set Accuracy: %f\n', accuracy_trained * 100);

pred = predict(Theta1, Theta2, Theta3, testX);
accuracy = mean(double(pred == testY));
fprintf('\nTest Set Accuracy: %f\n', accuracy * 100);

% Plot iteration v cost & accuracy graph
n = 1; % number of full trainings
total_cost = cost; 
total_accuracy = [0 ; accuracy];
total_overfit = [0; accuracy_trained - accuracy];

f1 = figure('Name', 'Cost');
hold off;
plot(1:iterations, cost, 'red');

f2 = figure('Name', 'Accuracy');
plot(0:iterations:n*iterations, total_accuracy, 'green');
hold on;
plot(0:iterations:n*iterations, total_overfit, 'blue');

drawnow;