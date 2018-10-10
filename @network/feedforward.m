%Stock_data is expected to be 9 x 1
function output = feedforward(obj, stock_data)
  %Calculates the values of each node based on
  %the values of the previous node and w/b
  %NOTE: obj.a1, obj.a2, and obj.a3 are local to this function
  %      must call this function inside another function if you want to use these values

  obj.a1 = relu(obj.w1*stock_data + obj.b1);
  obj.a2 = relu(obj.w2*obj.a1 + obj.b2);
  obj.a3 = obj.w3*obj.a2 + obj.b3;

  output = {obj.a1 obj.a2 obj.a3};
end