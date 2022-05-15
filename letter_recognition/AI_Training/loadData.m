close all; clc; clear; 

%%%% Loading Training Data %%%%
% X is a matrix of m columns and 784 rows where m is the number of data points, the 28x28 image is unrolled into a single row
% y is a column vector containing the correct labels of each data point
fprintf('Loading Data\n');
%load('Training_Data\processed_data_short_5000');	% 5000 training examples for training and another 5000 for testing
%load('Training_Data\processed_data_short');		% 25000 training examples for training but the full 18800 for testing
load('Training_Data\processed_data');				% 112800 training examples and 18800 for testing from EMNIST (Balanced): https://arxiv.org/pdf/1702.05373v1.pdf