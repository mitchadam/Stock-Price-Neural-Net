function [costs] = train (obj, data_matrix, learning_rate, epochs)
% Runs update batch a specified number of times in order to train network\
% Returns vector of value of cost function after each epoch.
% data_matrix = matrix of stock data obtained from get_data
% learning_rate = small decimal number
% epochs = number of times update_batch will be run over the data_matrix
% returns vector of value of cost function (on training data) after each epoch

% Cost over entire training data after each epoch
costs = zeros(1,epochs);

for i = 1:epochs
  obj.update_batch(data_matrix, learning_rate);
  costs(i) = obj.get_cost(data_matrix);
end % for

end