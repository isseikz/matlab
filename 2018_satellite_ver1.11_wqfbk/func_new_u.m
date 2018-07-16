function u_new = func_new_u(u,dudt,dTau)
% disp(u)
u_new = u + dudt * dTau;