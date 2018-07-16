function h = func_hamiltonian(x, xd, lambda,u,mu)

f = sat_func(x,u);

phi = transpose(xd) * xd;
L   = transpose(u(1:3)) * u(1:3) -0.01 * u(4) + x; 
pf  = transpose(lambda) * f(1:7);
mC  = mu * (transpose(u) * u -100);

h = phi + L + pf + mC;