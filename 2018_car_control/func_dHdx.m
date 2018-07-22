function dHdx = func_dHdx(Q, state, lambda)
    global length

    state_x     = state(1);
    state_y     = state(2);
    state_theta = state(3);
    state_v     = state(4);
    state_phi   = state(5);
    
    h1 = Q(1,1)*state_x;
    h2 = Q(2,2)*state_y;
    h3 = Q(3,3)*state_theta -lambda(1)*state_v*sin(state_theta) +lambda(2)*state_v*cos(state_theta);
    h4 = Q(4,4)*state_v     +lambda(1)*cos(state_theta)         +lambda(2)*sin(state_theta)         +lambda(3)*tan(state_phi)/length;
    h5 = Q(5,5)*state_phi;%   +lambda(3)*state_v/length/cos(state_phi)^2;
    
    dHdx = [h1, h2, h3, h4, h5];
