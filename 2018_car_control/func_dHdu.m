function dHdu = func_dHdu(R,input,lambda)
    dHdu = [lambda(4)+R(1,1)*input(1), lambda(5)+R(2,2)*input(2)]';