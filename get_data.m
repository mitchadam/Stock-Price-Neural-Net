function [out] = get_data(file_name, open_cells, close_cells, weekday_cells)
% Takes in xls file and returns matrix of data
% Returns matrix with columns open, close, weekday
% file_name is name of file including extension
% open_cells, close_cells, weekdays_cells are strings of excel selectors
%     e.g. 'B2:B254'

% Put open price in first column of data_matrix
data_matrix(:,1) = xlsread(file_name, open_cells);
data_matrix(:,2) = xlsread(file_name, close_cells);
data_matrix(:,3) = xlsread(file_name, weekday_cells);

out = data_matrix;
end

