function new_x = func_new_x(x,u,dtau)

global Inert

new_x(1) = x(1) + ((Inert(3)-Inert(2)) * x(2)* x(3) + u(1))/Inert(1)*dtau;
new_x(2) = x(2) + ((Inert(1)-Inert(3)) * x(1)* x(3) + u(2))/Inert(2)*dtau;
new_x(3) = x(3) + ((Inert(2)-Inert(1)) * x(1)* x(2) + u(3))/Inert(3)*dtau;
new_x(4) = x(4) + 0.5 * (+x(7)*x(1) -x(6)*x(2) +x(5)*x(3)) * dtau;
new_x(5) = x(5) + 0.5 * (+x(6)*x(1) +x(7)*x(2) -x(4)*x(3)) * dtau;
new_x(6) = x(6) + 0.5 * (-x(5)*x(1) +x(5)*x(2) +x(7)*x(3)) * dtau;
new_x(7) = x(7) + 0.5 * (-x(4)*x(1) -x(4)*x(2) -x(6)*x(3)) * dtau;

