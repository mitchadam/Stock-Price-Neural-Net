function cost = get_cost(obj, data_matrix)
% Returns scalar value of cost function for the network over the data given
% data_matrix = matrix of stock data obtained from get_data

% Vector to store cost for each training example (each individual day)
individual_costs = zeros(1,size(data_matrix,1)-4);

for i = 5:size(data_matrix,1)

  % Creates a row vector that is 9x1 to input into feedforward
  % Obtains previous four days open and close price as
  % well as weekday
  data_input = [data_matrix(i-1,1) data_matrix(i-2,1) data_matrix(i-3,1)...
  data_matrix(i-4,1) data_matrix(i-1,2) data_matrix(i-2,2) data_matrix(i-3,2)...
  data_matrix(i-4,2) data_matrix(i,3) ];
  data_input = transpose(data_input);

  network_result = obj.feedforward(data_input);

  predicted = network_result{3};
  actual = data_matrix(i,2); % actual closing price

  individual_costs(i) = 0.5*(predicted-actual)^2;
end % for

% Calculate average cost
cost = sum(individual_costs)/length(individual_costs);

end