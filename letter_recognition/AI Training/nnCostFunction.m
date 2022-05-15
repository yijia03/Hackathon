function [J grad] = nnCostFunction(nn_params, input_layer_size, hidden_layer_size, hidden_layer_2_size, num_labels, X, y, lambda)

layer1 = hidden_layer_size * (input_layer_size + 1);
layer2 = layer1 + hidden_layer_2_size * (hidden_layer_size + 1);

Theta1 = reshape(nn_params(1 : layer1), hidden_layer_size, (input_layer_size + 1));
Theta2 = reshape(nn_params(layer1 + 1 : layer2), hidden_layer_2_size, (hidden_layer_size + 1));
Theta3 = reshape(nn_params(layer2 + 1 : end), num_labels, (hidden_layer_2_size + 1));

m = size(X, 1);
         
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));
Theta3_grad = zeros(size(Theta3));


% Feedforward the neural network and return the cost in the variable J
% Return Theta_grad as partial derivatives for cost gradients 

h = zeros(m, 1);
for i = 1:m
	x = X(i,:);
	
	a1 = [1 x];
	
	z2 = a1 * Theta1';
	a2 = sigmoid(z2);
	a2 = [1 a2];
	
	z3 = a2 * Theta2';
	a3 = sigmoid(z3);
	a3 = [1 a3];
	
	z4 = a3 * Theta3';
	a4 = sigmoid(z4);
	
	% cost function
	classifier = zeros(1, num_labels);
	classifier(y(i)) = 1;
	J = J + sum(-classifier .* log(a4) - (1 - classifier) .* log(1 - a4));
	
	% gradient
	err4 = (a4 - classifier)';	
	err3 = (Theta3' * err4)(2:end,:) .* sigmoidGradient(z3)';
	err2 = (Theta2' * err3)(2:end,:) .* sigmoidGradient(z2)';
	
	Theta3_grad = Theta3_grad + err4 * a3;
	Theta2_grad = Theta2_grad + err3 * a2;
	Theta1_grad = Theta1_grad + err2 * a1;
endfor

% cost function
J = J / m;

temp = sum(sum(Theta1(:,2:end) .^ 2)) + sum(sum(Theta2(:,2:end) .^ 2)) + sum(sum(Theta3(:,2:end) .^ 2));
temp = temp * lambda / (2 * m);
J = J + temp;

% gradient
Theta1_grad = Theta1_grad / m;
Theta2_grad = Theta2_grad / m;
Theta3_grad = Theta3_grad / m;

temp1 = Theta1(:,2:end) .* lambda ./ m;
temp1 = [zeros(size(temp1, 1), 1) temp1];
Theta1_grad = Theta1_grad + temp1;

temp2 = Theta2(:,2:end) .* lambda ./ m;
temp2 = [zeros(size(temp2, 1), 1) temp2];
Theta2_grad = Theta2_grad + temp2;

temp3 = Theta3(:, 2:end) .* lambda ./ m;
temp3 = [zeros(size(temp3, 1), 1) temp3];
Theta3_grad = Theta3_grad + temp3;

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:) ; Theta3_grad(:)];

end
