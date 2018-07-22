function dPhidx = func_dPhidx(Q, state)
%     state_x     = state(1);
%     state_y     = state(2);
%     state_theta = state(3);
%     state_v     = state(4);
%     state_phi   = state(5);
    d = zeros(5,1);
    for i = 1:5
        d(i) = Q(i,i)*state(i);
    end
    dPhidx = d;