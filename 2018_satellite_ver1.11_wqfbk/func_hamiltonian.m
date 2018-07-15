function h = func_hamiltonian(x, xd, lambda,u,mu)

f = sat_func(x,u);

phi = transpose(xd) * xd
L   = transpose(u) * u
pf  = transpose(lambda) * f(1:7)
mC  = mu * (transpose(u) * u -100)

h = phi + L + pf + mC;