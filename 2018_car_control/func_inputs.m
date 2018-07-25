function inputs = func_inputs(R, lambda)
%     disp(lambda(4))
    inputs(1) = -lambda(4) / R(1,1);
    inputs(2) = -lambda(5) / R(2,2);