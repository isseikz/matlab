function u_new = func_new_u(u,dudt,dTau, N)
u_new(1,1:N) = transpose(u(1,1:N)) + dudt(1:N) * dTau;
u_new(2,1:N) = transpose(u(2,1:N)) + dudt(1:N) * dTau;
u_new(3,1:N) = transpose(u(3,1:N)) + dudt(1:N) * dTau;