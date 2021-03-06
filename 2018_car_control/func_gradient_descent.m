function [input] = func_gradient_descent(alpha)
% Gradient descent method
% 2018/07/26 isseikz

% sample code
eps = 1.0;               % 入力の変化に伴う関数の値の変化
alpha = 0.1;             % 学習率
uk = zeros(2,1);         % k番目の入力
uk1 = [0;0];             % k+1番目の入力

% 関数値の変化がeps以下になるまで繰り返す
while eps > 1.0e-3       
    uk1 = uk - alpha * dfdu_test(uk);
    eps = abs(norm(f_test(uk1)) - norm(f_test(uk)));
    uk = uk1;
end

input = uk;

