function [input] = car_control_pd(pos, the, vel, fai, target, length, t);
omega = 1;
zeta = 0.7;
input(1) = - omega^2 * pos(2,1) - 2 *omega * zeta * vel;
input(2) = - omega^2 * (the - pi/2);