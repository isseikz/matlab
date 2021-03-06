function dhdx = func_dhdx(x,xd,lambda)

global Inert

w = x(1:3);
q = x(4:7);
l = lambda;
I = Inert;

% lambda f
dhdx(1) = w(1) + l(2)*(I(1)-I(3))/I(2) * w(3) + l(3)*(I(2)-I(1))/I(3) * w(2) + 0.5 * ( l(4)*q(1)+l(5)*q(2)-l(6)*q(3)-l(7)*q(4));
dhdx(2) = w(2) + l(1)*(I(3)-I(2))/I(1) * w(3) + l(3)*(I(2)-I(1))/I(3) * w(1) + 0.5 * (-l(6)*q(3)+l(7)*q(4)-l(4)*q(1)+l(5)*q(2));
dhdx(3) = w(3) + l(1)*(I(3)-I(2))/I(1) * w(2) + l(2)*(I(1)-I(3))/I(2) * w(1) + 0.5 * ( l(5)*q(2)-l(4)*q(1)+l(7)*q(4)-l(6)*q(3));
dhdx(4) = q(1) + 0.5 * (-l(7)*w(1) +l(6)*w(2) -l(5)*w(3));
dhdx(5) = q(2) + 0.5 * (-l(6)*w(1) -l(7)*w(2) +l(4)*w(3));
dhdx(6) = q(3) + 0.5 * ( l(5)*w(1) -l(4)*w(2) -l(7)*w(3));
dhdx(7) = q(4) + 0.5 * ( l(4)*w(1) +l(2)*w(2) +l(6)*w(3));

% L
% err = x - xd;
% % err = x;
% for i=1:7
%     dhdx(i) = dhdx(i) + err(i)^2;
% end

for i=1:7
    dhdx(i) = dhdx(i) + 2 * x(i);
end