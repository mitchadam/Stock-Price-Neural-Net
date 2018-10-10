function [out] = relu(x)
% Applies relu function to column vector of weighted sum
% Outputs activation column vector

for i = 1:length(x)

  if x(i)<0
    out(i,1) = 0.1*x(i);
  else
    out(i,1) = x(i);
  end

end % for

end