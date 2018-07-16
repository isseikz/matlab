function new_lambda = func_new_lambda(lambda, x, q, dtau)

xd(4:7) = q;
xd(1) = 0;
xd(2) = 0;
xd(3) = 0;

new_lambda = lambda + transpose(func_dhdx(x,xd,lambda)) * dtau;