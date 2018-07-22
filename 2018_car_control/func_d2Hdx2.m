function d2Hdx2 = func_d2Hdx2(Q, state, lambda)
    global length
    
    state_x     = state(1);
    state_y     = state(2);
    state_theta = state(3);
    state_v     = state(4);
    state_phi   = state(5);
    
    d2Hdx2 = zeros(5);
    d2Hdx2(1,1) = Q(1,1);
    d2Hdx2(2,2) = Q(2,2);
    d2Hdx2(3,3) = Q(3,3)-lambda(1)*state_v*cos(state_theta)-lambda(2)*state_v*sin(state_theta);
    d2Hdx2(3,4) = -lambda(1)*sin(state_theta)+lambda(2)*cos(state_theta);
    d2Hdx2(4,3) = d2Hdx2(3,4);
    d2Hdx2(4,4) = Q(4,4);
%     d2Hdx2(3,5) = lambda(3)/length/cos(state_phi)^2;
    d2Hdx2(5,5) = Q(5,5);% + lambda(3)*state_v/length*2*sin(state_phi)/cos(state_phi)^3;
%     d2Hdx2(5,3) = d2Hdx2(3,5);
    
    d2Hdx2 = d2Hdx2';