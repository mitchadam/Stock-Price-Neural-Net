% Use this script to test functionality

% Initialize a network
net = network([4 4]);
disp(net.a3);

% Create array of apple stock data
apple_data = get_data('AppleStockData.xlsx', 'B2:B245','E2:E245', 'H2:H245');

% Compute average gradient for one batch of apple data


cost = [1:60];
for i = 1:50
net.update_batch(apple_data, 0.000002);
disp(net.a3);
cost(i) = (net.a3-172);
end 

plot(cost);
