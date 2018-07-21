% car_navigation
% main program
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
	clear all
	close all
%
    global t x
    global length
    global dt tf
    global tgx tgy tgthe
    global casenumber
%
    fp = fopen('result.dat','wt');
    fprintf(fp,'     t     ,     X     ,     Y     , attitude  , velocity  , steering  ,input_accel,input_steer\n');
%
    casenumber = input('Enter a Case-number:');
    car_init;
%
    x_list = [];
    t_list = [];    %for output
%
% simulation
%
set(0,'Units','pixels')
scnsize = get(0,'ScreenSize');
pos1 = [scnsize(3)/4 scnsize(4)/2 scnsize(3)/4 scnsize(4)/2];
pos2 = [scnsize(3)/2 scnsize(4)/2 scnsize(3)/4 scnsize(4)/2];
%
    while(1)
        pos = x(1:2);
        the = x(3);
        vel = x(4);
        fai = x(5);
        target = [tgx, tgy, tgthe];
    % control
        [input] = car_control(pos, the, vel, fai, target, length, t);
        x(6:7) = input;
    % print output
        fprintf(fp,'%11f,%11f,%11f,%11f,%11f,%11f,%11f\n',t,x); 
    % motion
        [x(1:5),t] = car_rgk(x(1:5),input,dt,t);
        tdisp = int16(100.0*t);
        if mod(tdisp,20) == 0
            car_display;
        end
        car_evaluate;
        x_list = [x_list, x];
        t_list = [t_list, t];     
        if t >= tf
			break
		end
    end
    fprintf(fp,'%11f,%11f,%11f,%11f,%11f,%11f,%11f\n',t,x); 
    fclose(fp);
    car_plot;
    
    