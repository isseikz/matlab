function [input] = car_control(pos, the, vel, fai, target, length, t);
% car_control.m
% input program
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% design the control law here
% input(1) is the accelaration[m/s^2]
% input(2) is the delta[deg/s]

global casenumber

input(1) = -0.1*pos(2)-0.75*vel

relx=[target(1);target(2)]-pos

delta = -0.01*relx(1)

%delta = 0;

input(2) = delta * pi / 180.0;
