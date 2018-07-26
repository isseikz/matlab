function [input] = func_gradient_descent(alpha)
% Gradient descent method
% 2018/07/26 isseikz

% sample code
eps = 1.0;               % ���͂̕ω��ɔ����֐��̒l�̕ω�
alpha = 0.1;             % �w�K��
uk = zeros(2,1);         % k�Ԗڂ̓���
uk1 = [0;0];             % k+1�Ԗڂ̓���

% �֐��l�̕ω���eps�ȉ��ɂȂ�܂ŌJ��Ԃ�
while eps > 1.0e-3       
    uk1 = uk - alpha * dfdu_test(uk);
    eps = abs(norm(f_test(uk1)) - norm(f_test(uk)));
    uk = uk1;
end

input = uk;

