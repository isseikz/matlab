function posT = HRprset()
% HRprset.m
%
% Initial Setting
%
% Revision history
% 150520 Created
% 150619 Kinematical check of state is added.
% 150619 Check of TTRTP is added.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global m_HR I_HR r_HR h_HR l_HR alpha
global STATE_A STATE_B STATE_C STATE_D
global STATE_E STATE_F STATE_G
global nde_
global svtime cntime dptime
global x_ dx_ qx_ t_ dth_
global N_pos N_the N_vel N_omg 
global N_trq N_fA N_fB N_state
global N_posAk N_velAk N_posBk N_velBk
global N_t_cmd
global TARGET_WIDTH TARGET_PERIOD
global N_TTRTP

%
svtime = 0.0;			% initial time to restore data [s]
cntime = 0.0;			% initial time to control [s]
dptime = 1.0+dth_;		% initial time to display data [s]
%
x_     = zeros(nde_,1);	% state variables
dx_    = zeros(nde_,1);	% 1st time derivative of state variables
qx_    = zeros(nde_,1); % auxiliary parameters for RKG integration
t_     = 0;				% time [s]
RANDN_STATE =     1;
randn('state',RANDN_STATE);% reset random number generator
rand ('state',RANDN_STATE);% reset random number generator
addpath('util');
%
%

%%%
t_cmd		= 1e-4;
trq			= t_cmd;
%%%
pos			= [0;h_HR];
the			= 0.0;
vel			= [0;0];
omg			= 0.0;
%%%
posT		= [0.5;0];	% target point position [m]
						% this value is changed during the contest.
%%%
posA		= pos + l_HR*[ cos(the+alpha);-sin(the+alpha)];
velA		= vel - l_HR*omg*[ sin(the+alpha); cos(the+alpha)];
posB		= pos - l_HR*[ cos(the-alpha);-sin(the-alpha)];
velB		= vel + l_HR*omg*[ sin(the-alpha); cos(the-alpha)];

state		= STATE_F;

% check state kinematically
if ( state~=set_state(pos,vel,the,omg,state) ),
	disp(sprintf('The initial condition is not well set.'));
	disp(sprintf('Press ctrl+C to cancel this program.'));
	pause;
end

%%% Check TTRTP (Time to reach the target point)
TTRTP	= x_(N_TTRTP);
switch state,
	case {STATE_B,STATE_C},
		if ( abs(posA(1)-posT(1))-TARGET_WIDTH/2<=eps ),
			TTRTP = TTRTP+dth_;
		end
	case {STATE_D,STATE_E},
		if ( abs(posB(1)-posT(1))-TARGET_WIDTH/2<=eps ),
			TTRTP = TTRTP+dth_;
		end
	case {STATE_F,STATE_G},
		if ( (abs(posA(1)-posT(1))-TARGET_WIDTH/2<=eps) | ...
			 (abs(posB(1)-posT(1))-TARGET_WIDTH/2<=eps) ),
			TTRTP = TTRTP+dth_;
		end
	otherwise,
		TTRTP = 0;
end

x_(N_pos)	= pos;
x_(N_the)	= the;
x_(N_vel)	= vel;
x_(N_omg)	= omg;
x_(N_trq)	= trq;
x_(N_state)	= state;
x_(N_t_cmd)	= t_cmd;
x_(N_posAk)	= posA;
x_(N_velAk)	= velA;
x_(N_posBk)	= posB;
x_(N_velBk)	= velB;
x_(N_TTRTP)	= TTRTP;
%%%%%
