function output = update_batch (obj,data_matrix,learning_rate)

% Creates a starting cell array that we will add to each loop
% Will then calcualte the average at the end
% This will then be used in gradient decent
running_total_gradient = {zeros(size(obj.w1)) zeros(size(obj.w2)) zeros(size(obj.w3))...
zeros(size(obj.b1)) zeros(size(obj.b2)) zeros(size(obj.b3)) };

for i = 5:size(data_matrix,1)

  % Creates a row vector that is 9x1 to input into backprop
  % Obtains previous four days open and close price as
  % well as weekday
  data_input = [data_matrix(i-1,1) data_matrix(i-2,1) data_matrix(i-3,1)...
  data_matrix(i-4,1) data_matrix(i-1,2) data_matrix(i-2,2) data_matrix(i-3,2)...
  data_matrix(i-4,2) data_matrix(i,3) ];

  data_input = transpose(data_input);


  new_gradient = obj.backprop(data_input, data_matrix(i,2));

% Adds the calcualted gradient to the runnong total gradient
  for j = 1:6
    running_total_gradient{j} = running_total_gradient{j} + new_gradient{j};
  end
end

% Calculates the average gradient of one batch
for i = 1:6
  average_gradient{i} = running_total_gradient{i}./(size(data_matrix,1)-4);
end


% Update the network object's weights and biasesq
obj.w1 = obj.w1 - learning_rate*average_gradient{1};
obj.w2 = obj.w2 - learning_rate*average_gradient{2};
obj.w3 = obj.w3 - learning_rate*average_gradient{3};

obj.b1 = obj.b1 - learning_rate*average_gradient{4};
obj.b2 = obj.b2 - learning_rate*average_gradient{5};
obj.b3 = obj.b3 - learning_rate*average_gradient{6};

end