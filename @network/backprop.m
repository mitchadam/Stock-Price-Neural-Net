function output = backprop(obj, input_data, desired)
  % Returns cell array of derivative matrix for each weight matrix and bias vector
  %   (i.e. the gradient of the cost function with respect to each weight and bias)
  % input_data = 9x1 vector of input data to the network (previous days' stock data)
  % desired = the actual output we want to the network to produce for the given input
  %           (i.e. the actual stock price for the next day)

  % Calls feedforward on input. Returns cell array of activations in each layer
  activation_array = obj.feedforward(input_data);

  % Initialize matrix of zeros that will be the same size of each weight matrix/bias vector
  dw1 = zeros(size(obj.w1));
  dw2 = zeros(size(obj.w2));
  dw3 = zeros(size(obj.w3));

  db1 = zeros(size(obj.b1));
  db2 = zeros(size(obj.b2));
  db3 = zeros(size(obj.b3));

  % Calculate matrix of derivatives for weights to last layer (w3)
  dw3 = (activation_array{3}-desired)*transpose(activation_array{2});
  % Calculate matrix of derivatives for bias last layer (b3)
  db3 = (activation_array{3}-desired);

  % Calculate matrix of derivatives for w2
  % The activation matrix for the previous layer must be transposed and multiplied from the right
  %     to turn the error (delta) column vector into the weight derivative matrix
  dw2 = ( (transpose(obj.w3)*(activation_array{3}-desired)).*drelu(obj.w2*activation_array{1}+obj.b2) )*transpose(activation_array{1});
  % Calculate matrix of derivatives for b2
  db2 = (transpose(obj.w3)*(activation_array{3}-desired)).*drelu(obj.w2*activation_array{1}+obj.b2);

  % Calculate matrix of derivatives for w1
  % Where db2 is also equal to error (delta) in layer 2
  % In this case, instead of an activation from the previous layer, we use input_data (a 9x1 vector)
  dw1 = ( (transpose(obj.w2)*db2).*drelu(obj.w1*input_data+obj.b1) )*transpose(input_data);
  % Calculate matrix of derivatives for b1
  db1 = ( (transpose(obj.w2)*db2).*drelu(obj.w1*input_data+obj.b1) );

  % Outputs the partial derivatives as a cell array
  output = {dw1 dw2 dw3 db1 db2 db3};
end