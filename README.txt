Stock Neural Network
====================
Created by Mitchell Adam and Ryan Shukla

Description
-----------
This program will create and train a neural network in order to attempt to
predict stock prices. The network will take the open and close prices for the
previous 4 days as well as the weekday of the new day as an input. The network
will output the predicted closing stock price of the new day. Gradient descent
is used to train the network.

Users can choose to train a network using the default parameters or specify
their own parameters. After training, the user can test on the default data or
their own data.

How to Use
----------
1. Run the script 'run_network'
2. When prompted, specify whether you wish to train a network using the default
   parameters or specify your own parameters. (See below if specifying you own
   parameters)
4. Wait for the network to train. This may take a few minutes. When training is
   done, a plot will pop-up showing the cost on the training data over every
   training epoch. The cost function is the mean squared error over the entire
   training data set.
5. You will now be asked whether you want to train again. You can train again
   on the default training data or choose your own data (see below).
6. When you are done training, you will be asked which data you would like to
   test on. The default test data is found in "AppleStockData.xlsx.". If using
   your own test data, specify cells the same way you would in an Excel
   spreadsheet (see below). Select "Input manual data to test" if you wish to
   predict the price for one day.
7. From here, you may choose to test the network again on the same data or on
   different data.
8. Once you decide to stop testing, a network object is return to the workspace.
   It can be saved to a file and used later.

### If Specifying Your Own Parameters: ###
- When asked to "Input file name: ", enter the name of an Excel spreadsheet
  including extension ".xlsx". The default network is trained on
  "AppleStockData2016.xlsx".
- When asked to input the "open data", type in a range of cells in the Excel
  spreadsheet which contain the opening prices for the stock on each day. This
  should be something like "B2:B245"
- Enter the "close data" and "weekday data" the same way as "open data"
- Note: the weekday data should be a column of cells containing the day of the
  week converted to a single digit. (2-6 for Monday to Friday. The Excel
  WEEKDAY() function can be used for this)
- Note: The number of rows for open, close, and weekday data must match.
- The "nodes in the first layer" and the "nodes in the second layer" allow you
  to specify the number of nodes or neurons in each of the two hidden layers of
  the network. The default is 3 in the first layer and 2 in the second.
- The learning rate should be a small decimal number. The default is 0.000001.
  Too large a learning rate will cause gradient descent to fail.
- "times you would like to train" is the number of times that the gradient
  descent algorithm will be executed on the training data. This should be
  something like 200-500 times.

Resources
---------
While we took inspiration from the following sources, all of our code was
original.

Neural Network and Deep Learning by Michael Nielsen
http://neuralnetworksanddeeplearning.com/index.html

Stock market index prediction using artificial neural network
By Amin Hedayati, Moghaddama Moein, Morteza Esfandyaric
https://www.sciencedirect.com/science/article/pii/S2077188616300245
