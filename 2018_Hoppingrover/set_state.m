function [state] = set_state(pos,vel,the,omg,state_org)
% set_state.m
%
% set "state" based on kinematical conditions
%
% Revision history
% 150619 Created
% 150630 The contact point A versus B is checked by the attitude "the".
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global l_HR alpha
global STATE_A STATE_B STATE_C STATE_D
global STATE_E STATE_F STATE_G

cos_ta	= cos(the+alpha);
sin_ta	= sin(the+alpha);
cos_tb	= cos(the-alpha);
sin_tb	= sin(the-alpha);

posA	= pos + l_HR*[ cos(the+alpha);-sin(the+alpha)];
velA	= vel - l_HR*omg*[ sin(the+alpha); cos(the+alpha)];
posB	= pos - l_HR*[ cos(the-alpha);-sin(the-alpha)];
velB	= vel + l_HR*omg*[ sin(the-alpha); cos(the-alpha)];

vAx		= velA(1);
vAy		= velA(2);
pAy		= posA(2);
vBx		= velB(1);
vBy		= velB(2);
pBy		= posB(2);

THRESH = eps;

if ( pAy>THRESH ),
	if ( pBy>THRESH ),
		state	= STATE_A;
	else
		if ( abs(vBx)<=eps ),
			state	= STATE_D;
		else
			state	= STATE_E;
		end
	end
else
	if ( pBy>THRESH ),
		if ( abs(vAx)<=eps ),
			state	= STATE_B;
		else
			state	= STATE_C;
		end
	else
		if ( abs(vBx)<=eps ),
			state	= STATE_F;
		else
			state	= STATE_G;
		end
	end
end

%
% to change the state from "contact" to "float"
% by just looking at kinematics,
% the threshold shall be large enough not to
% invoke fluctuation of the state.
%
if ( (state~=state_org)&(state==STATE_A) ),
	THRESH = 1e-4;

	if ( (pAy>THRESH)&(pBy>THRESH) ),
		state	= STATE_A;
	else
		state	= state_org;
	end
end

%
% to change the state from "contact at 2 points" to "contact at 1 point"
% by just looking at kinematics,
% the threshold shall be large enough not to
% invoke fluctuation of the state.
%
if ( (state~=state_org)&(ismember(state_org,[STATE_F,STATE_G]))&...
	 (ismember(state,[STATE_B,STATE_C,STATE_D,STATE_E])) ),
	THRESH = 1e-4;

	if ( pAy>THRESH ),
		if ( abs(vBx)<=eps ),
			state	= STATE_D;
		else
			state	= STATE_E;
		end
	else
		state	= state_org;
	end

	if ( pBy>THRESH ),
		if ( abs(vAx)<=eps ),
			state	= STATE_B;
		else
			state	= STATE_C;
		end
	else
		state	= state_org;
	end
end

%
% to check the contact point A versus B
% the angle theta is a simple measure.
%
if ( (state==state_org)&ismember(state_org,[STATE_B,STATE_C]) ),
	THRESH = eps;
	if ( the<-THRESH ),
		if ( abs(vBx)<=eps ),
			state	= STATE_D;
		else
			state	= STATE_E;
        end
	else
		state	= state_org;
	end
end

if ( (state==state_org)&ismember(state_org,[STATE_D,STATE_E]) ),
	THRESH = eps;

	if ( the> THRESH ),
		if ( abs(vAx)<=eps ),
			state1	= STATE_B;
		else
			state1	= STATE_C;
		end
	else
		state	= state_org;
	end
end

