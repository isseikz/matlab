function [] = HRsplot(ts,xs,posT)
% HRsplot.m
%
% Output graphs
%
% Revision history
% 150520 Created
% 150630 Units were corrected.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global N_pos N_the N_vel N_omg 
global N_trq N_fA N_fB N_state
global N_posAk N_velAk N_posBk N_velBk
global N_t_cmd ndisp
global STATE_A STATE_B STATE_C STATE_D
global STATE_E STATE_F STATE_G
global VXA_MIN VYA_MIN
global TARGET_WIDTH TARGET_PERIOD

tmin = min(ts); tmax = max(ts);
R2D  = 180/pi;  D2R  = pi/180;
%%%
%
figure( 1);
clf
for j=1:2,
	subplot(3,1,j);
	plot(ts,xs(N_pos(j),:),'k.-'); hold on
	ylabel(['pos ',sprintf(' %s [m]',char(double('x')+(j-1)))]);
	grid
	xlim([tmin,tmax]);
end
j = 3;
subplot(3,1,j);
plot(ts,xs(N_the,:)*R2D,'k.-'); hold on
ylabel(['\theta [deg]']);
grid
xlim([tmin,tmax]);

xlabel('time [s]');
%

%
figure( 2);
clf
for j=1:2,
	subplot(3,1,j);
	plot(ts,xs(N_vel(j),:),'k.-'); hold on
	ylabel(['vel ',sprintf(' %s [m/s]',char(double('x')+(j-1)))]);
	grid
	xlim([tmin,tmax]);
end
j = 3;
subplot(3,1,j);
plot(ts,xs(N_omg,:)*R2D,'k.-'); hold on
ylabel(['\omega [deg/s]']);
grid
xlim([tmin,tmax]);

xlabel('time [s]');

%
figure( 3);
clf
for j=1:2,
	subplot(2,1,j);
	plot(ts,xs(N_posAk(j),:),'k.-'); hold on
	if ( j==1 ),
		plot([tmin,tmax],posT(j)*[1,1]+TARGET_WIDTH/2,'r-.','LineWidth',2.0);
		plot([tmin,tmax],posT(j)*[1,1]-TARGET_WIDTH/2,'r-.','LineWidth',2.0);
		legend('A:kinematics','target point','location','best');
	else
		legend('A:kinematics','location','best');
	end
	ylabel(['pos A',sprintf(' %s [m]',char(double('x')+(j-1)))]);
	grid
	xlim([tmin,tmax]);
end
xlabel('time [s]');

%
figure( 4);
clf
for j=1:2,
	subplot(2,1,j);
	plot(ts,xs(N_velAk(j),:),'k.-'); hold on
	ylabel(['vel A',sprintf(' %s [m/s]',char(double('x')+(j-1)))]);
	grid
	xlim([tmin,tmax]);
end
xlabel('time [s]');


%
figure( 5);
clf
for j=1:2,
	subplot(2,1,j);
	plot(ts,xs(N_posBk(j),:),'k.-'); hold on
	if ( j==1 ),
		plot([tmin,tmax],posT(j)*[1,1]+TARGET_WIDTH/2,'r-.','LineWidth',2.0);
		plot([tmin,tmax],posT(j)*[1,1]-TARGET_WIDTH/2,'r-.','LineWidth',2.0);
		legend('B:kinematics','target point','location','best');
	else
		legend('B:kinematics','location','best');
	end
	ylabel(['pos B',sprintf(' %s [m]',char(double('x')+(j-1)))]);
	grid
	xlim([tmin,tmax]);
end
xlabel('time [s]');

%
figure( 6);
clf
for j=1:2,
	subplot(2,1,j);
	plot(ts,xs(N_velBk(j),:),'k.--'); hold on
	ylabel(['vel B',sprintf(' %s [m/s]',char(double('x')+(j-1)))]);
	grid
	xlim([tmin,tmax]);
end
xlabel('time [s]');

%
figure( 7);
clf
plot(ts,xs(N_state,:),'k.-'); hold on
grid
xlim([tmin,tmax]);
xlabel('time [s]');
ylabel('sliding state');
ylim([STATE_A-0.5,STATE_G+0.5]);
set(gca,'YTick',[STATE_A:1:STATE_G]);
set(gca,'YTickLabel',{'A','B','C','D','E','F','G'});

%
figure( 8);
clf
for j=1:2,
	subplot(2,1,j);
	plot(ts,xs(N_fA(j),:), 'bo-'); hold on
	plot(ts,xs(N_fB(j),:), 'rx-'); 
	legend('fA','fB');
	ylabel(['fA,fB',sprintf(' %s [N]',char(double('x')+(j-1)))]);
	grid
	xlim([tmin,tmax]);
end
xlabel('time [s]');

%
figure( 9);
clf
	plot(ts,xs(N_trq,:), 'bo-'); hold on
	plot(ts,xs(N_t_cmd,:), 'rx-'); 
	legend('input','command');
	ylabel('torque [Nm]');
	grid
	xlim([tmin,tmax]);
xlabel('time [s]');
%
