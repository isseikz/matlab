% function t_cmd = Control(pos,vel,the,omg,posT,t,smt,state, myInput)function t_cmd = Control(pos,vel,the,omg,posT,t,smt,state)%% Control.m%%%%%%% INPUTS%%% --- Spacecraft%%% pos : the position of the c.m. of the rover%%%       expressed in the asteroid surface frame [m], (a 2x1 vector)%%% vel : the velocity of the c.m. of the rover %%%       expressed in the asteroid surface frame [m/s], (a 2x1 vector)%%% the : the attitude of the rover [rad], (a scalar)%%% omg : the attitude rate of the rover [rad/s], (a scalar)%%% --- Others%%% posT : the position of the target point [m], (a 2x1 vector)%%% t : current simulation time [s], (a scalar)%%% smt : total simulation time [s], (a scalar)%%% state : the rover state (A,B,..., or G) [], (a scalar)%%%%%% OUTPUTS%%% t_cmd : torquer input command [Nm], (a scalar)%---%------------------------------------------------------------% Please write your own algorithm here!%------------------------------------------------------------% index = fix(t/1) + 1;% index = fix(300 * (posT(1) - pos(1))/0.5);% if index < 1,%     index = 1;% end% if index > 300,%     index = 300;% end% t_cmd = myInput(index);% % 165 [s]% if (posT(1) - pos(1)) > 0.01 && t < 5,%     t_cmd = 1.0e-4 * t/5;% elseif    (posT(1) - pos(1)) > 0.01 && t < 10,%     t_cmd = 1.0e-4;% elseif (posT(1) - pos(1)) > 0.19%     t_cmd = -(the+pi/24) -omg;% elseif state == 1%     t_cmd = -0.000005 * (the + cos(pos(2)/0.05/sqrt(2))) - 0.005 * omg;% else%     t_cmd = 0;% %      t_cmd = -0.01 * (the + cos(pos(2)/0.05/sqrt(2)));% end% % 160 [s]% if (posT(1) - pos(1)) > 0.01 && t < 5,%     t_cmd = 1.5e-4;% elseif (posT(1) - pos(1)) > 0.19%     t_cmd = -(the+pi/24) -omg;% elseif state == 1%     t_cmd = -0.000005 * (the + cos(pos(2)/0.05/sqrt(2))) - 0.005 * omg;% else%     t_cmd = 0;% %      t_cmd = -0.01 * (the + cos(pos(2)/0.05/sqrt(2)));% end% 167[s], tToouch%myInput = [3.7406e-07	-3.8634e-06	7.8586e-06	6.7618e-06	-3.7188e-06	5.9812e-06	-2.3816e-06	9.5483e-06	1.0382e-07	9.5166e-06	-2.8119e-06	9.335e-06	8.0891e-06	-6.5532e-06	5.49e-06	-1.0202e-06	8.9719e-06	9.7554e-06	-6.9286e-06	-7.3692e-06	4.9104e-06	3.8926e-07	-2.6066e-06	5.6e-06	9.4831e-08	9.8924e-06	-1.3004e-07	-3.6925e-06	7.1517e-06	3.4622e-06	-7.0223e-06	-1.1567e-06	1.669e-08	5.9026e-06	9.8867e-06	8.1933e-06	6.8973e-06	8.4355e-06	4.1901e-06	2.2852e-06	-8.5769e-06	2.3294e-06	2.882e-06	5.7018e-06	7.8528e-06	2.1066e-06	-5.6595e-06	3.3397e-06	-6.4541e-06	5.765e-06	-3.948e-06	-6.7709e-06	-2.8323e-06	-1.2144e-06	-6.6033e-06	-6.8985e-06	6.9863e-06	8.4961e-06	6.3259e-06	4.4741e-06	1.6923e-06	4.8333e-06	-5.962e-06	9.8813e-06	3.7406e-07	-3.8634e-06	7.8586e-06	6.7618e-06	-3.7188e-06	5.9812e-06	-2.3816e-06	9.5483e-06	1.0382e-07	9.5166e-06	-2.8119e-06	9.335e-06	8.0891e-06	-6.5532e-06	5.49e-06	-1.0202e-06	8.9719e-06	9.7554e-06	-6.9286e-06	-7.3692e-06	4.9104e-06	3.8926e-07	-2.6066e-06	5.6e-06	9.4831e-08	9.8924e-06	-1.3004e-07	-3.6925e-06	7.1517e-06	3.4622e-06	-7.0223e-06	-1.1567e-06	1.669e-08	5.9026e-06	9.8867e-06	8.1933e-06	6.8973e-06	8.4355e-06	4.1901e-06	2.2852e-06	-8.5769e-06	2.3294e-06	2.882e-06	5.7018e-06	7.8528e-06	2.1066e-06	-5.6595e-06	3.3397e-06	-6.4541e-06	5.765e-06	-3.948e-06	-6.7709e-06	-2.8323e-06	-1.2144e-06	-6.6033e-06	-6.8985e-06	6.9863e-06	8.4961e-06	6.3259e-06	4.4741e-06	1.6923e-06	4.8333e-06	-5.962e-06	9.8813e-06	3.7406e-07	-3.8634e-06	7.8586e-06	6.7618e-06	-3.7188e-06	5.9812e-06	-2.3816e-06	9.5483e-06	1.0382e-07	9.5166e-06	-2.8119e-06	9.335e-06	8.0891e-06	-6.5532e-06	5.49e-06	-1.0202e-06	8.9719e-06	9.7554e-06	-6.9286e-06	-7.3692e-06	4.9104e-06	3.8926e-07	-2.6066e-06	5.6e-06	9.4831e-08	9.8924e-06	-1.3004e-07	-3.6925e-06	7.1517e-06	3.4622e-06	-7.0223e-06	-1.1567e-06	1.669e-08	5.9026e-06	9.8867e-06	8.1933e-06	6.8973e-06	8.4355e-06	4.1901e-06	2.2852e-06	-8.5769e-06	2.3294e-06	2.882e-06	5.7018e-06	7.8528e-06	2.1066e-06	-5.6595e-06	3.3397e-06	-6.4541e-06	5.765e-06	-3.948e-06	-6.7709e-06	-2.8323e-06	-1.2144e-06	-6.6033e-06	-6.8985e-06	6.9863e-06	8.4961e-06	6.3259e-06	4.4741e-06	1.6923e-06	4.8333e-06	-5.962e-06	9.8813e-06	3.7406e-07	-3.8634e-06	7.8586e-06	6.7618e-06	-3.7188e-06	5.9812e-06	-2.3816e-06	9.5483e-06	1.0382e-07	9.5166e-06	-2.8119e-06	9.335e-06	8.0891e-06	-6.5532e-06	5.49e-06	-1.0202e-06	8.9719e-06	9.7554e-06	-6.9286e-06	-7.3692e-06	4.9104e-06	3.8926e-07	-2.6066e-06	5.6e-06	9.4831e-08	9.8924e-06	-1.3004e-07	-3.6925e-06	7.1517e-06	3.4622e-06	-7.0223e-06	-1.1567e-06	1.669e-08	5.9026e-06	9.8867e-06	8.1933e-06	6.8973e-06	8.4355e-06	4.1901e-06	2.2852e-06	-8.5769e-06	2.3294e-06	2.882e-06	5.7018e-06	7.8528e-06	2.1066e-06	-5.6595e-06	3.3397e-06	-6.4541e-06	5.765e-06	-3.948e-06	-6.7709e-06	-2.8323e-06	-1.2144e-06	-6.6033e-06	-6.8985e-06	6.9863e-06	8.4961e-06	6.3259e-06	4.4741e-06	1.6923e-06	4.8333e-06	-5.962e-06	9.8813e-06	3.7406e-07	-3.8634e-06	7.8586e-06	6.7618e-06	-3.7188e-06	5.9812e-06	-2.3816e-06	9.5483e-06	1.0382e-07	9.5166e-06	-2.8119e-06	9.335e-06	8.0891e-06	-6.5532e-06	5.49e-06	-1.0202e-06	8.9719e-06	9.7554e-06	-6.9286e-06	-7.3692e-06	4.9104e-06	3.8926e-07	-2.6066e-06	5.6e-06	9.4831e-08	9.8924e-06	-1.3004e-07	-3.6925e-06	7.1517e-06	3.4622e-06	-7.0223e-06	-1.1567e-06	1.669e-08	5.9026e-06	9.8867e-06	8.1933e-06	6.8973e-06	8.4355e-06	4.1901e-06	2.2852e-06	-8.5769e-06	2.3294e-06	2.882e-06	5.7018e-06	7.8528e-06]% global tTouch% % 160 [s]% if (posT(1) - pos(1)) > 0.01 && t < 5%     t_cmd = 1.5e-4;% elseif (posT(1) - pos(1)) > 0.15%     t_cmd = -(the+pi/24) -omg;% % elseif ~exist('tTouch', 'var')% %     disp('enable')% %     tTouch = t% %     t_cmd = -(the+pi/24) -omg;% else%     t_cmd = myInput(fix(t-115)+1);% end% % % % 154.2[s]myInput = [4.0812e-06	-1.42e-06	-8.8097e-06	3.8318e-06	9.9438e-06	-3.9334e-06	8.7823e-06	2.9498e-06	9.6707e-06	8.2117e-06	-7.5325e-06	7.6797e-06	1.1607e-06	2.8508e-06	2.7672e-06	3.4907e-06	-2.7093e-06	-3.5364e-06	-7.4838e-06	-9.6813e-06	-6.0983e-06	-8.2779e-06	2.1175e-06	-7.7365e-06	6.5131e-07	5.8575e-06	5.3841e-06	8.8013e-06	-9.3296e-06	7.4565e-06	-2.2951e-06	1.8058e-06	-4.4202e-06	-8.0663e-06	-1.7027e-06	3.0208e-06	-5.1189e-06	-4.7491e-06	8.5091e-06	4.1403e-07	-1.9617e-06	3.1454e-06	-2.6433e-06	9.9411e-07	4.3321e-06	-5.6141e-06	9.8031e-06	-2.5184e-06	-3.0997e-06	2.3879e-08	-4.0977e-06	6.7457e-08	3.6632e-07	-3.7341e-06	-8.8655e-06	7.1166e-06	7.5547e-06	-3.4452e-06	1.236e-06	-5.2581e-06	-9.6677e-06	8.1549e-06	-6.5157e-06	2.6508e-06	4.0812e-06	-1.42e-06	-8.8097e-06	3.8318e-06	9.9438e-06	-3.9334e-06	8.7823e-06	2.9498e-06	9.6707e-06	8.2117e-06	-7.5325e-06	7.6797e-06	1.1607e-06	2.8508e-06	2.7672e-06	3.4907e-06	-2.7093e-06	-3.5364e-06	-7.4838e-06	-9.6813e-06	-6.0983e-06	-8.2779e-06	2.1175e-06	-7.7365e-06	6.5131e-07	5.8575e-06	5.3841e-06	8.8013e-06	-9.3296e-06	7.4565e-06	-2.2951e-06	1.8058e-06	-4.4202e-06	-8.0663e-06	-1.7027e-06	3.0208e-06	-5.1189e-06	-4.7491e-06	8.5091e-06	4.1403e-07	-1.9617e-06	3.1454e-06	-2.6433e-06	9.9411e-07	4.3321e-06	-5.6141e-06	9.8031e-06	-2.5184e-06	-3.0997e-06	2.3879e-08	-4.0977e-06	6.7457e-08	3.6632e-07	-3.7341e-06	-8.8655e-06	7.1166e-06	7.5547e-06	-3.4452e-06	1.236e-06	-5.2581e-06	-9.6677e-06	8.1549e-06	-6.5157e-06	2.6508e-06	4.0812e-06	-1.42e-06	-8.8097e-06	3.8318e-06	9.9438e-06	-3.9334e-06	8.7823e-06	2.9498e-06	9.6707e-06	8.2117e-06	-7.5325e-06	7.6797e-06	1.1607e-06	2.8508e-06	2.7672e-06	3.4907e-06	-2.7093e-06	-3.5364e-06	-7.4838e-06	-9.6813e-06	-6.0983e-06	-8.2779e-06	2.1175e-06	-7.7365e-06	6.5131e-07	5.8575e-06	5.3841e-06	8.8013e-06	-9.3296e-06	7.4565e-06	-2.2951e-06	1.8058e-06	-4.4202e-06	-8.0663e-06	-1.7027e-06	3.0208e-06	-5.1189e-06	-4.7491e-06	8.5091e-06	4.1403e-07	-1.9617e-06	3.1454e-06	-2.6433e-06	9.9411e-07	4.3321e-06	-5.6141e-06	9.8031e-06	-2.5184e-06	-3.0997e-06	2.3879e-08	-4.0977e-06	6.7457e-08	3.6632e-07	-3.7341e-06	-8.8655e-06	7.1166e-06	7.5547e-06	-3.4452e-06	1.236e-06	-5.2581e-06	-9.6677e-06	8.1549e-06	-6.5157e-06	2.6508e-06	4.0812e-06	-1.42e-06	-8.8097e-06	3.8318e-06	9.9438e-06	-3.9334e-06	8.7823e-06	2.9498e-06	9.6707e-06	8.2117e-06	-7.5325e-06	7.6797e-06	1.1607e-06	2.8508e-06	2.7672e-06	3.4907e-06	-2.7093e-06	-3.5364e-06	-7.4838e-06	-9.6813e-06	-6.0983e-06	-8.2779e-06	2.1175e-06	-7.7365e-06	6.5131e-07	5.8575e-06	5.3841e-06	8.8013e-06	-9.3296e-06	7.4565e-06	-2.2951e-06	1.8058e-06	-4.4202e-06	-8.0663e-06	-1.7027e-06	3.0208e-06	-5.1189e-06	-4.7491e-06	8.5091e-06	4.1403e-07	-1.9617e-06	3.1454e-06	-2.6433e-06	9.9411e-07	4.3321e-06	-5.6141e-06	9.8031e-06	-2.5184e-06	-3.0997e-06	2.3879e-08	-4.0977e-06	6.7457e-08	3.6632e-07	-3.7341e-06	-8.8655e-06	7.1166e-06	7.5547e-06	-3.4452e-06	1.236e-06	-5.2581e-06	-9.6677e-06	8.1549e-06	-6.5157e-06	2.6508e-06	4.0812e-06	-1.42e-06	-8.8097e-06	3.8318e-06	9.9438e-06	-3.9334e-06	8.7823e-06	2.9498e-06	9.6707e-06	8.2117e-06	-7.5325e-06	7.6797e-06	1.1607e-06	2.8508e-06	2.7672e-06	3.4907e-06	-2.7093e-06	-3.5364e-06	-7.4838e-06	-9.6813e-06	-6.0983e-06	-8.2779e-06	2.1175e-06	-7.7365e-06	6.5131e-07	5.8575e-06	5.3841e-06	8.8013e-06	-9.3296e-06	7.4565e-06	-2.2951e-06	1.8058e-06	-4.4202e-06	-8.0663e-06	-1.7027e-06	3.0208e-06	-5.1189e-06	-4.7491e-06	8.5091e-06	4.1403e-07	-1.9617e-06	3.1454e-06	-2.6433e-06	9.9411e-07	4.3321e-06]if (posT(1) - pos(1)) > 0.01 && t < 5    t_cmd = 1.5e-4;elseif t < 90    t_cmd = -(the+pi/24) -omg;else    t_cmd = myInput(fix(t-90)+1);end% % 151[s]% myInput =[9.0556e-06	7.9719e-06	5.3743e-06	-2.11e-06	-1.19e-06	9.393e-06	7.994e-06	3.2638e-06	-7.3242e-06	8.117e-07	7.1416e-06	-3.2892e-06	-5.9372e-06	-4.1134e-06	9.5494e-06	-3.6253e-06	6.8655e-06	-3.6506e-09	-1.0481e-06	8.7244e-06	-6.0983e-06	-8.2779e-06	2.1175e-06	-7.7365e-06	6.5131e-07	5.8575e-06	5.3841e-06	8.8013e-06	-9.3296e-06	2.0121e-06	-2.2951e-06	1.8058e-06	-4.4202e-06	-8.0663e-06	1.4222e-06	3.0208e-06	-5.1189e-06	-4.7491e-06	-5.0349e-06	4.1403e-07	-1.9617e-06	3.1454e-06	-2.6433e-06	9.9411e-07	4.3321e-06	-5.6141e-06	9.8031e-06	-2.5184e-06	-3.0997e-06	2.3879e-08	-7.5463e-06	9.3535e-06	3.6632e-07	-1.1141e-06	-8.8655e-06	7.1166e-06	7.5547e-06	-3.4452e-06	1.236e-06	-5.2581e-06	-9.6677e-06	7.8042e-06	-6.5157e-06	2.0485e-06	9.0556e-06	7.9719e-06	5.3743e-06	-2.11e-06	-1.19e-06	9.393e-06	7.994e-06	3.2638e-06	-7.3242e-06	8.117e-07	7.1416e-06	-3.2892e-06	-5.9372e-06	-4.1134e-06	9.5494e-06	-3.6253e-06	6.8655e-06	-3.6506e-09	-1.0481e-06	8.7244e-06	-6.0983e-06	-8.2779e-06	2.1175e-06	-7.7365e-06	6.5131e-07	5.8575e-06	5.3841e-06	8.8013e-06	-9.3296e-06	2.0121e-06	-2.2951e-06	1.8058e-06	-4.4202e-06	-8.0663e-06	1.4222e-06	3.0208e-06	-5.1189e-06	-4.7491e-06	-5.0349e-06	4.1403e-07	-1.9617e-06	3.1454e-06	-2.6433e-06	9.9411e-07	4.3321e-06	-5.6141e-06	9.8031e-06	-2.5184e-06	-3.0997e-06	2.3879e-08	-7.5463e-06	9.3535e-06	3.6632e-07	-1.1141e-06	-8.8655e-06	7.1166e-06	7.5547e-06	-3.4452e-06	1.236e-06	-5.2581e-06	-9.6677e-06	7.8042e-06	-6.5157e-06	2.0485e-06	9.0556e-06	7.9719e-06	5.3743e-06	-2.11e-06	-1.19e-06	9.393e-06	7.994e-06	3.2638e-06	-7.3242e-06	8.117e-07	7.1416e-06	-3.2892e-06	-5.9372e-06	-4.1134e-06	9.5494e-06	-3.6253e-06	6.8655e-06	-3.6506e-09	-1.0481e-06	8.7244e-06	-6.0983e-06	-8.2779e-06	2.1175e-06	-7.7365e-06	6.5131e-07	5.8575e-06	5.3841e-06	8.8013e-06	-9.3296e-06	2.0121e-06	-2.2951e-06	1.8058e-06	-4.4202e-06	-8.0663e-06	1.4222e-06	3.0208e-06	-5.1189e-06	-4.7491e-06	-5.0349e-06	4.1403e-07	-1.9617e-06	3.1454e-06	-2.6433e-06	9.9411e-07	4.3321e-06	-5.6141e-06	9.8031e-06	-2.5184e-06	-3.0997e-06	2.3879e-08	-7.5463e-06	9.3535e-06	3.6632e-07	-1.1141e-06	-8.8655e-06	7.1166e-06	7.5547e-06	-3.4452e-06	1.236e-06	-5.2581e-06	-9.6677e-06	7.8042e-06	-6.5157e-06	2.0485e-06	9.0556e-06	7.9719e-06	5.3743e-06	-2.11e-06	-1.19e-06	9.393e-06	7.994e-06	3.2638e-06	-7.3242e-06	8.117e-07	7.1416e-06	-3.2892e-06	-5.9372e-06	-4.1134e-06	9.5494e-06	-3.6253e-06	6.8655e-06	-3.6506e-09	-1.0481e-06	8.7244e-06	-6.0983e-06	-8.2779e-06	2.1175e-06	-7.7365e-06	6.5131e-07	5.8575e-06	5.3841e-06	8.8013e-06	-9.3296e-06	2.0121e-06	-2.2951e-06	1.8058e-06	-4.4202e-06	-8.0663e-06	1.4222e-06	3.0208e-06	-5.1189e-06	-4.7491e-06	-5.0349e-06	4.1403e-07	-1.9617e-06	3.1454e-06	-2.6433e-06	9.9411e-07	4.3321e-06	-5.6141e-06	9.8031e-06	-2.5184e-06	-3.0997e-06	2.3879e-08	-7.5463e-06	9.3535e-06	3.6632e-07	-1.1141e-06	-8.8655e-06	7.1166e-06	7.5547e-06	-3.4452e-06	1.236e-06	-5.2581e-06	-9.6677e-06	7.8042e-06	-6.5157e-06	2.0485e-06	9.0556e-06	7.9719e-06	5.3743e-06	-2.11e-06	-1.19e-06	9.393e-06	7.994e-06	3.2638e-06	-7.3242e-06	8.117e-07	7.1416e-06	-3.2892e-06	-5.9372e-06	-4.1134e-06	9.5494e-06	-3.6253e-06	6.8655e-06	-3.6506e-09	-1.0481e-06	8.7244e-06	-6.0983e-06	-8.2779e-06	2.1175e-06	-7.7365e-06	6.5131e-07	5.8575e-06	5.3841e-06	8.8013e-06	-9.3296e-06	2.0121e-06	-2.2951e-06	1.8058e-06	-4.4202e-06	-8.0663e-06	1.4222e-06	3.0208e-06	-5.1189e-06	-4.7491e-06	-5.0349e-06	4.1403e-07	-1.9617e-06	3.1454e-06	-2.6433e-06	9.9411e-07	4.3321e-06]% if (posT(1) - pos(1)) > 0.01 && t < 10%     t_cmd = 2.0e-4*(10-t)/10;% elseif t < 110%     t_cmd = -(the+pi/24) -omg;% else%     t_cmd = myInput(fix(t)+1);% end% if (posT(1) - pos(1)) > 0.01 && t < 10%     t_cmd = 2.0e-4*(10-t)/10;% elseif t < 90%     t_cmd = -(the) -omg;% else%     t_cmd = myInput(fix(t)+1);% end