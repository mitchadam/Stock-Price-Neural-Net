% This is the main function that will be used to call
% the other sub-functions

function [net] = run_network()

%This is the Initialization portion of the functon
    %This continues to ask user until a vald input is recievied
    prompt_user = true;
    while prompt_user

      %Promts user
      custom = input('Would you like to use the default network? (Y/N):','s');

      % This sets the default network paramaters if user choses to use defualt network
      % Default trains on 2016 apple stock data
      % Note that the default testing is on 2017 apple stock
      if lower(custom) == 'y'
        data = get_data('AppleStockData2016.xlsx', 'B3:B253','E3:E253', 'H3:H253');
        net_size = [3  2];
        learning_rate = 0.000001;
        epochs = 500;

        %Stops prompting user
        prompt_user = false;

      % If user choses in input custom paramaters
      elseif lower(custom) == 'n'

        % Prompts user to input training data in the form of .xlsx file
        fprintf('\nPlease enter the data you would like to train.');
        fprintf('\nEnter in the form "AppleStockData.xlsx", "B2:B253","E2:E253", "H2:H253"');
        fprintf('Input more than 5 days of data. Use option (3) if testing less than 5 days.\n');
        training_file_name = input('Input File name: ','s');
        training_file_open = input('Input the open data, use the form B2:B253: ','s');
        training_file_close = input('Input the close data, use the form E2:E253: ' ,'s');
        training_file_weekday = input('Input the weekday data, use the form H2:H253: ','s');

        % Sets the training to data to what the user chooses
        data = get_data(training_file_name, training_file_open,training_file_close,training_file_weekday);

        % Prompts the user for the network size
        fprintf('\nPlease enter the network size');
        net_size1 = input('\nEnter the nodes in the the first layer:');
        net_size2 = input('Enter the nodes in the the second layer:');
        net_size = [net_size1 net_size2];

        % Learning rate and training iterations
        learning_rate = input('\nPlease enter the learning rate:');
        epochs = input('\nEnter how many times you would like to train:');

        % Stops prompting user
        prompt_user = false;

      % Invalid Input
      else
        fprintf('\nSorry that is invalid please try again\n');
        prompt_user = true;
      end
    end

%This begins the training section of the functions

  %Initialize network
  net = network(net_size);

  %Train network
  cost = net.train(data, learning_rate, epochs);

  %Display Graph of cost
  plot(cost);
  title('Cost on training data');
  xlabel('Epoch');
  ylabel('Cost');

  %Prompts the user if they want to train again
  train_again = input('Would you like to train again(Y/N):','s');

  %Determines if the user would like to train again
  train =false;
  if lower(train_again) == 'y'
    train = true;
  end

  %Continues to train the same network if specified by the user
  %Note that beyond this point the network cannot be edited
  %Only the training data can be changed
  while train
    %Prompts user about what data to train on
    same_data = input('Would you like to train on the same data?: ', 's');

    %Trains on the same data
    if lower(same_data) == 'y'
      cost = net.train(data, learning_rate, epochs);
    %Trains on new data
    elseif lower(same_data) == 'n'

      %Prompts the user to input the new data to train on
      fprintf('\nPlease enter the data you would like to train.');
      fprintf('\nEnter in the form "AppleStockData.xlsx", "B2:B253","E2:E253", "H2:H253"');
      fprintf('Input more than 5 days of data. Use option (3) if testing less than 5 days.\n');
      training_file_name = input('Input File name: ','s');
      training_file_open = input('Input the open data, use the form B2:B253: ','s');
      training_file_close = input('Input the close data, use the form E2:E253: ' ,'s');
      training_file_weekday = input('Input the weekday data, use the form H2:H253: ','s');

      % Sets training data
      data = get_data(training_file_name, training_file_open,training_file_close,training_file_weekday);
      %Trains on new training data
      cost = net.train(data, learning_rate, epochs);
    else
    end

    %Displays the cost function graph
    plot(cost);
    title('Cost on training data');
    xlabel('Epoch');
    ylabel('Cost');

    %Checks to see if the user would like to continue training
    train_again = input('Would you like to train again(Y/N):','s');
    if lower(train_again) == 'n'
      train = false;
    end
  end
%This ends the training section of the function

%This begins the testing section of the function
test = true;
while test

  %Prompts the user to specify what data they want to have trained
  test = input('\nWould you like to:\n  (1)Test using default data\n  (2)Test using data from a file\n  (3)Input manual data to test\n');


  switch test

  % User wants to test on the defualt data
  case 1
  % This sets the testing data to the apple Stock for 2017
  %Note that the data was trained on 2016 apple stock
    test_data = get_data('AppleStockData.xlsx', 'B2:B254','E2:E254', 'H2:H254');

    % Get actual closing prices for each day
    actuals = test_data(:,2);
    actuals = transpose(actuals);

    % Delete first 4 entries since those days do not have enough data for
    % the network to predict prices
    actuals = actuals(5:end);

    % Initialize vector of predictions
    predictions = zeros(1,size(test_data,1)-4);

    % This loops through and predicts the price for each day of the default
    % testing data
    for i = 5:size(test_data,1)

      % create 9x1 column vector to pass to feedforward with the test data
      test_data_input = [test_data(i-1,1) test_data(i-2,1) test_data(i-3,1)...
      test_data(i-4,1) test_data(i-1,2) test_data(i-2,2) test_data(i-3,2)...
      test_data(i-4,2) test_data(i,3) ];
      test_data_input = transpose(test_data_input);

      % This passes the test data to feedforward and outputs the predicted prices
      feedforward_result = net.feedforward(test_data_input);
      predictions(i-4) = feedforward_result{3};

    end

    % Create new figure window to plot the prediction graph
    figure
    plot(actuals, 'g')
    hold on
    plot(predictions, 'r')
    hold off

    title('Predicted Stock Price vs Actual Stock Price');
    xlabel('Day');
    ylabel('Stock Price');
    legend('Actual Price','Predicted Price')

  % User wants to test data from a file
  case 2

    fprintf('Input more than 5 days of data. Use option (3) if testing less than 5 days.\n');

    % Prompts the user for the data to teat on
    test_file_name = input('Input File name, use the form AppleStockData.xlsx: ','s');
    test_file_open = input('Input the open data, use the form B2:B253: ','s');
    test_file_close = input('Input the open data, use the form E2:E253: ' ,'s');
    test_file_weekday = input('Input the weekday data, use the form H2:H253: ','s');

    % Sets the test data to what was inputed by the user
    test_data = get_data(test_file_name, test_file_open,test_file_close,test_file_weekday);

    % Get actual closing prices for each day
    actuals = test_data(:,2);
    actuals = transpose(actuals);

    % Delete first 4 entries since there is not enough data on these days for
    % the network to predict prices
    actuals = actuals(5:end);

    % Initialize vector of predictions
    predictions = zeros(1,size(test_data,1)-4);

    % This lopps through and predicts the closing price for each day that
    % was in the user inputted data
    for i = 5:size(test_data,1)

      % create 9x1 column vector to pass to feedforward
      test_data_input = [test_data(i-1,1) test_data(i-2,1) test_data(i-3,1)...
      test_data(i-4,1) test_data(i-1,2) test_data(i-2,2) test_data(i-3,2)...
      test_data(i-4,2) test_data(i,3) ];
      test_data_input = transpose(test_data_input);

      % This passes the test data to feedforward and outputs the predicted prices
      feedforward_result = net.feedforward(test_data_input);
      predictions(i-4) = feedforward_result{3};

    end

    % Create new figure window for predictions graph
    figure
    plot(actuals, 'g');
    hold on
    plot(predictions, 'r');
    hold off

    title('Predicted Stock Price vs Actual Stock Price');
    xlabel('Day');
    ylabel('Stock Price');
    legend('Actual Price','Predicted Price')

% The user just wants to predict the next day close price
% by manually entering data
  case 3
    fprintf('This is used to predict the next days closing price\n');
    % Prompts the user in order to create the 9x1 vector need to pass to
    % feedforward
    open4 = input('\nPlease input the open price for 4th previous day: ');
    close4 = input('Please input the close price for 4th previous day: ');
    open3 = input('Please input the open price for 3rd previous day: ');
    close3 = input('Please input the close price for 3rd previous day: ');
    open2 = input('Please input the open price for 2nd previous day: ');
    close2 = input('Please input the close price for 2nd previous day: ');
    open1 = input('Please input the open price for previous day: ');
    close1 = input('Please input the close price for previous day: ');
    day_week = input('What day of the week are you trying to predict(M:2 F:6): ');

    % Column vector is neccesary for feedforward
    data = transpose([open4 open3 open2 open1 close4 close3 close2 close1 day_week]);

    % This obtains the predicted close price
    prediction = net.feedforward(data);

    %Displays the predicted close price
    fprintf('Predicted Price: $%.2f\n', prediction{3});
  end

% Tests to see if the user wants to test more data
  test_again = input('Would you like to test on more data?(Y/N): ','s');
  if lower(test_again) =='n'
    test = false;
  end

end

end
