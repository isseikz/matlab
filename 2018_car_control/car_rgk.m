function [x,t] = car_rgk(x,input,dt,t)
% car_rgk.m
% runge-kutta program
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
x0   = x;
dx1  = car_func(x0,input);
x1   = x0+0.5*dt*dx1;
dx2  = car_func(x1,input);
x2   = x0+0.5*dt*dx2;
dx3  = car_func(x2,input);
x3   = x0+1.0*dt*dx3;
dx4  = car_func(x3,input);
x    = x0 + 1/6*dt*(dx1+2*dx2+2*dx3+dx4);
t    = t+dt;