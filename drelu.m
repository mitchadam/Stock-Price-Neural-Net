function out = drelu(x)
% Derivative of relu
% Input and output column vectors

for i = 1:length(x)

  if x(i)<0
    out(i,1) = 0.1; % slope of relu for x<0
  else
    out(i,1) = 1;   % slope of relu for x>=0
  end

end % for

end