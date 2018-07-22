function dFdx = func_dFdx(state)
    global length
    
    state_x     = state(1);
    state_y     = state(2);
    state_theta = state(3);
    state_v     = state(4);
    state_phi   = state(5);
    
    dFdx = zeros(5);
    dFdx(3,1) = -state_v * sin(state_theta);
    dFdx(3,2) =  state_v * cos(state_theta);
    dFdx(4,1) =  cos(state_theta);
    dFdx(4,2) =  sin(state_theta);
    dFdx(4,3) =  tan(state_phi)/length;
    dFdx(5,3) =  state_v/ length / cos(state_phi)^2;
    
    dFdx = dFdx';