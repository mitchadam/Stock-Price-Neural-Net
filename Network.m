classdef  Network
   properties
   % Creates paramaters of network
      hidden_layers = 2; % Not changeable
      w1; %Weights
      w2;
      w3;
      b1; %Biases
      b2;
      b3;
      a1; % Activations
      a2;
      a3; % This is the output
   end
   methods
    function obj = Network(nodes)
      obj.w1 = randn(nodes(1),9);
      obj.w2 = randn (nodes(2),nodes(1));
      obj.w3 = randn (1,nodes(2));
      obj.b1 = rand(nodes(1),1);
      obj.b2 = rand(nodes(2),1);
      obj.b3 = rand(1,1);
      obj.a1 = zeros(nodes(1),1);
      obj.a2 = zeros(nodes(2),1);
      obj.a3 = 0;
    end
  end
end

