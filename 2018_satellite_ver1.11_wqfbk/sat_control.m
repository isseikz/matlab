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

global u udot U

Tf = 2;
T = Tf * (1-exp(-0.5*t));
N = 100;
dTau = T/N;

xopt = zeros(7,N);
lambda = zeros(7,N);
input = zeros(1,3);
mu    = zeros(6,N);

% xopt(4:7,1) = quart - transpose(q);
% xopt(4:7,N) = 0;
lambda(:,N) = 100*[0,0,0,q(1),q(2),q(3),q(4)];

% ‰Šúó‘Ô‚Ìİ’è
if t<0.02
    for i = 1:3
        xopt(i,:) = omega(i)*ones(1,N);
    end
    for i = 4:7
        xopt(i,:) = quart(i)*ones(1,N);
    end
    lambda = xopt;
    mu(:,:)       = 1;
    u = zeros(6,N);
    
    for j=1:N-1
        U(1,j) = - lambda(1,j) / 2 / Inert(1) / mu(:);
        U(2,j) = - lambda(2,j) / 2 / Inert(2) / mu(:);
        U(3,j) = - lambda(3,j) / 2 / Inert(3) / mu(:);
        U(4,j) = 0;
        U(5,j) = 0;
        U(6,j) = 0;
    end
else
    
    for i=1:N-1
        xopt(:,i+1) = func_new_x(xopt(:,i),u(:,i),dTau);
    end
    for i = 1:N-1
        lambda(:,N-i) = func_new_lambda(lambda(:,N+1-i), xopt(:,N+1-i), q, dTau);
    end
%     disp(lambda(1,1))

    dFdu = zeros(5*N);
    F    = zeros(5*N,1);
    disp(t)
    for j=1:N
        for k=1:4
            dFdu(k+5*(j-1),k+5*(j-1)) = 2*(1+U(5*j));
        end
        dFdu(5*j,5*j) = 2 * U(5*j);
        
        F(1+5*(j-1):4+5*(j-1)) = func_dhdu(U(1+5*(j-1):4+5*(j-1)),lambda(1:4,j),U(5*j),0.1);
        F(5+5*(j-1)) = U(1+5*(j-1):4+5*(j-1)) * transpose(U(1+5*(j-1):4+5*(j-1))) - 100;
    end
%     disp(transpose(F))
    dudt = gmres(dFdu,-F/0.01,10);
    U = func_new_u(U,dudt,dTau);
end
% disp(func_dhdu(U(1:4),lambda(1:4,j),U(5),0.01))

% disp(U(5))
for i = 1:3
    input(i) = U(i);
end