function [domg,fA,fB] = calc_frc_domg(vel,the,omg,state,trq)
% calc_frc_domg.m
%
% Calculate forces (fA and fB) and angular acceleration (domg)
%
% Revision history
% 150520 Created
% 150619 In the states F and G, 
%		 domg is set such that the omega becomes zero and
%        (fAy,fBy) are set such that the y-component of y
%		 becomes zero after one integration step.
% 150630 In the states F and G, (fAy,fBy) reflects domg.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global m_HR I_HR r_HR h_HR l_HR alpha g mu_sta mu_dyn
global STATE_A STATE_B STATE_C STATE_D
global STATE_E STATE_F STATE_G
global VXA_MIN
global mu_dyn
global dth_

cos_ta	= cos(the+alpha);
sin_ta	= sin(the+alpha);
cos_tb	= cos(the-alpha);
sin_tb	= sin(the-alpha);

velA	= vel - l_HR*omg*[ sin(the+alpha); cos(the+alpha)];
velB	= vel + l_HR*omg*[ sin(the-alpha); cos(the-alpha)];

vAx		= velA(1);
vBx		= velB(1);

cos_ta	= cos(the+alpha);
sin_ta	= sin(the+alpha);
cos_tb	= cos(the-alpha);
sin_tb	= sin(the-alpha);

switch state,
	%--- Contact Point A
	case STATE_B, % Pivots
		domg	= 1/(I_HR+m_HR*l_HR^2)*(trq-m_HR*g*l_HR*cos_ta);
		fA		= m_HR*l_HR*(domg*[ sin_ta; cos_ta] + omg^2*[ cos_ta;-sin_ta]);
		fA(2)	= fA(2) + m_HR*g;
		fB		= [0;0];
	case STATE_C, % Slides
		domg	= trq - m_HR*l_HR*...
		          (g - l_HR*omg^2*sin_ta)*(cos_ta-sign(vAx)*mu_dyn*sin_ta);
		domg	= domg/(I_HR+m_HR*l_HR^2*cos_ta*(cos_ta-sign(vAx)*mu_dyn*sin_ta));
		fA		= m_HR*l_HR*(domg*[ sin_ta; cos_ta] + omg^2*[ cos_ta;-sin_ta]);
		fA(2)	= fA(2) + m_HR*g;
		fA(1)	= -sign(vAx)*mu_dyn*fA(2);
		fB		= [0;0];
	%--- Contact Point B
	case STATE_D, % Pivots
		domg	= 1/(I_HR+m_HR*l_HR^2)*(trq+m_HR*g*l_HR*cos_tb);
		fB		=-m_HR*l_HR*(domg*[ sin_tb; cos_tb] + omg^2*[ cos_tb;-sin_tb]);
		fB(2)	= fB(2) + m_HR*g;
		fA		= [0;0];
	case STATE_E, % Slides
		domg	= trq + m_HR*l_HR*...
		          (g + l_HR*omg^2*sin_tb)*(cos_tb-sign(vBx)*mu_dyn*sin_tb);
		domg	= domg/(I_HR+m_HR*l_HR^2*cos_tb*(cos_tb-sign(vBx)*mu_dyn*sin_tb));
		fB		=-m_HR*l_HR*(domg*[ sin_tb; cos_tb] + omg^2*[ cos_tb;-sin_tb]);
		fB(2)	= fB(2) + m_HR*g;
		fB(1)	= -sign(vBx)*mu_dyn*fB(2);
		fA		= [0;0];
	%--- Contact Points A and B
	case STATE_F, % Stops
		domg	= -omg/dth_;
        dvely	= -vel(2)/dth_;
		fAx		= 0;
		fBx		= 0;
		fAy		= (1/2)*(m_HR*g+m_HR*dvely+(trq-I_HR*domg)/(l_HR*cos(alpha)));
		fBy		= (1/2)*(m_HR*g+m_HR*dvely-(trq-I_HR*domg)/(l_HR*cos(alpha)));
		fA		= [fAx;fAy];
		fB		= [fBx;fBy];
	case STATE_G, % Slides
		domg	= -omg/dth_;
        dvely	= -vel(2)/dth_;
        fABy	= inv([ l_HR*cos(alpha)-sign(vAx)*mu_dyn*l_HR*sin(alpha),...
                       -l_HR*cos(alpha)-sign(vBx)*mu_dyn*l_HR*sin(alpha);...
                        1, 1])*[trq-I_HR*domg;m_HR*g+m_HR*dvely];
		fAy		= fABy(1);
		fBy		= fABy(2);
		fAx		= -sign(vAx)*mu_dyn*fAy;
		fBx		= -sign(vBx)*mu_dyn*fBy;
		fA		= [fAx;fAy];
		fB		= [fBx;fBy];
	%--- Hop
	case STATE_A, % Hop
		domg	= trq/I_HR;
		fA		= [0;0];
		fB		= [0;0];
	otherwise, 
		disp('state is not defined!-------------');
		pause;
end
