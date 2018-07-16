function input, mu = func_optimul_newton(ua, ub, mua, mub, lambda, N)

% % Obtainn optimal u, dhdu = 0: newton method

U = zeros(4,N);
for j = 1:N
    ua = [-10,-10,-10, 0];
    ub = [ 10, 10, 10, 0];
    for k = 1:4
        dhdua = func_dhdu(ua,lambda(1:4,j),mu,0.1);
        dhdub = func_dhdu(ub,lambda(1:4,j),mu,0.1);
        while abs(dhdua(k) - dhdub(k)) > 1.0e-3
            dhdua = func_dhdu(ua,lambda(1:4,j),mu,0.1);
            dhdub = func_dhdu(ub,lambda(1:4,j),mu,0.1);
            midu = (ua(k) + ub(k))/2;
            disp(dhdua(k) - dhdub(k))
            if dhdua(k) - dhdub(k) < 0
                ub(k) = midu;
            else
                ua(k) = midu;
            end
        end
    end
    U(:,j) = ua(:);
end
inputs = U;