function dhdu = func_dhdu(u,lambda,mu,r)

global Inert

dhdu(1) = 2 * (1 + mu) * u(1) + lambda(1) / Inert(1);
dhdu(2) = 2 * (1 + mu) * u(2) + lambda(2) / Inert(2);
dhdu(3) = 2 * (1 + mu) * u(3) + lambda(3) / Inert(3);
dhdu(4) = - r + 2 * mu * u(4);