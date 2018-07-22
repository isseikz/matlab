function f = func_f(state, inputs)
    global length
    
    state_theta = state(3);
    state_v     = state(4);
    state_phi   = state(5);

    f = zeros(5,1);
    
    f(1) = state_v * cos(state_theta);
    f(2) = state_v * sin(state_theta);
    f(3) = state_v * tan(state_phi)/length;
    f(4) = inputs(1);
    f(5) = inputs(2);