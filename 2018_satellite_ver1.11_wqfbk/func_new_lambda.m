function new_lambda = func_new_lambda(lambda, x, q, dtau)

xd(1:4) = q;
xd(5) = 0;
xd(6) = 0;
xd(7) = 0;

new_lambda = lambda + transpose(func_dhdx(x,lambda)) * dtau;