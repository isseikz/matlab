function d2Phidx2 = func_d2Phidx2(Q)
    d2Phidx2 = zeros(5);
    for i = 1:5
        d2Phidx2(i,i) = Q(i,i);
    end