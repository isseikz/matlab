function [input] = sat_control(omega, quart, t)
% sat_control.m
% input program
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% design the control law here
% input(1:3) are the input torques for each axis

global Inert torque_max
global casenumber tin
global flag target_1 target_2 target_3

if flag == 1
    q=target_1;
elseif flag == 2
    q=target_2;
elseif flag == 3
    q=target_3;
end
    
% q_hat=[ q(4)  q(3) -q(2) -q(1);
%        -q(3)  q(4)  q(1) -q(2);
%         q(2) -q(1)  q(4) -q(3)]*quart;
%     
% Kq=30.0*eye(3);
% Kd=30.0*eye(3);
% 
% input_vec=-Kq*q_hat-Kd*omega;
% 
% input(1) = input_vec(1);
% input(2) = input_vec(2);
% input(3) = input_vec(3);

global u

T = 20;
N = 50;
dTau = T/N;

xopt = zeros(7,N+1);
lambda = zeros(7,N);
input = zeros(1,3);

xopt(4:7,1) = quart;
lambda(:,N) = [0,0,0,q(1),q(2),q(3),q(4)];

u(1,1:50)=ones(1,N)/4/Inert(1);
u(2,1:50)=ones(1,N)/4/Inert(2);
u(3,1:50)=ones(1,N)/4/Inert(3);
u(4,1:50)=ones(1,N)*0.01;

for i=1:N-1
    xopt(:,i+1) = func_new_x(xopt(:,i),u(:,i),dTau);
end
for i = 1:N-1
    lambda(:,N-i) = func_new_lambda(lambda(:,N+1-i), xopt(:,N+1-i), q, dTau);
end

dFdu = zeros(5*N);
F    = zeros(5*N,1);
for i = 1:N
    d2hdu2 = 4 * eye(4);
    dcdu   = 2 * u(1:4);
    dFdu(1+5*(i-1):4+5*(i-1),1:4) = d2hdu2(:,:);
    dFdu(5+5*(i-1),1:4) = dcdu(:);
    F(1+5*(i-1):4+5*(i-1)) = func_dhdu(u(1:4,i),lambda(1:4,i),1,0.01);
end
dudt = gmres(dFdu,-F,10);
u = func_new_u(u,dudt,dTau,N);

for i = 1:3
    input(i) = u(i,1);
end