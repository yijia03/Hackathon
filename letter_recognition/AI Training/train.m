% Run this as many times as needed after running 'main' for additional training
nn_params = [Theta1(:) ; Theta2(:) ; Theta3(:)];
[nn_params, cost] = fmincg(costFunction, nn_params, options);	

layer1 = hidden_layer_size * (input_layer_size + 1);
layer2 = layer1 + hidden_layer_2_size * (hidden_layer_size + 1);

Theta1 = reshape(nn_params(1 : layer1), hidden_layer_size, (input_layer_size + 1));
Theta2 = reshape(nn_params(layer1 + 1 : layer2), hidden_layer_2_size, (hidden_layer_size + 1));
Theta3 = reshape(nn_params(layer2 + 1 : end), num_labels, (hidden_layer_2_size + 1));

pred = predict(Theta1, Theta2, Theta3, X);
accuracy_trained = mean(double(pred == y))
fprintf('\nTraining Set Accuracy: %f\n', accuracy_trained * 100);

pred = predict(Theta1, Theta2, Theta3, testX);
accuracy = mean(double(pred == testY));
fprintf('\nTest Set Accuracy: %f\n', accuracy * 100);

% Plotting Graphs
n++;
total_cost = [total_cost ; cost];
total_accuracy = [total_accuracy; accuracy];
total_overfit = [total_overfit; accuracy_trained - accuracy];

f1;
hold off;
plot(1:n*iterations, total_cost, 'red');

f2;
plot(0:iterations:n*iterations, total_accuracy, 'green');
hold on;
plot(0:iterations:n*iterations, total_overfit, 'blue');

drawnow;