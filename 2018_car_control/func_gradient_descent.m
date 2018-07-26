function [input] = func_gradient_descent(alpha)
% Gradient descent method
% 2018/07/26 isseikz

% sample code
eps = 1.0;               % “ü—Í‚Ì•Ï‰»‚É”º‚¤ŠÖ”‚Ì’l‚Ì•Ï‰»
alpha = 0.1;             % ŠwK—¦
uk = zeros(2,1);         % k”Ô–Ú‚Ì“ü—Í
uk1 = [0;0];             % k+1”Ô–Ú‚Ì“ü—Í

% ŠÖ”’l‚Ì•Ï‰»‚ªepsˆÈ‰º‚É‚È‚é‚Ü‚ÅŒJ‚è•Ô‚·
while eps > 1.0e-3       
    uk1 = uk - alpha * dfdu_test(uk);
    eps = abs(norm(f_test(uk1)) - norm(f_test(uk)));
    uk = uk1;
end

input = uk;

