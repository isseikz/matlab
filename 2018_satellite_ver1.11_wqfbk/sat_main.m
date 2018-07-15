% sat_control
% main program
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    clear all
	close all
%
    global t x 
    global dt tf
    global casenumber tin
    global Inert torque_max
    global flag target_1 target_2 target_3 flag_list
%
    fp = fopen('result.csv','wt');
    fprintf(fp,'     t     ,  omega_x  ,  omega_y  ,  omega_z  ,  quart_1  ,  quart_2  ,  quart_3  ,  quart_4  , torque_x  , torque_y  , torque_z  \n');
%
    casenumber = input('Enter a Case-number:');
    
    sat_init;
    
    sat_randominit;
    
%
    flag_list=[];
    x_list = [];
    t_list = [];    %for output
%
% simulation
%
    while(1)
        omega = x(1:3);
        quart = x(4:7);
    % control
        [input] = sat_control(omega, quart, t);
        x(8:10) = input;
    % print output
        fprintf(fp,'%11f,%11f,%11f,%11f,%11f,%11f,%11f,%11f,%11f,%11f,%11f\n',t,x); 
    % motion
        [x(1:7),t] = sat_rgk(x(1:7),input,dt,t);

        sat_evaluate;
        flag_list=[flag_list,flag];
        x_list = [x_list, x];
        t_list = [t_list, t]; 
    % 終了判定，flagが3を超えていたら終了，または時刻がtf以上
        if flag > 3
            if casenumber == 1
                fprintf ('time is %8.4f\n',t);
                break
            elseif casenumber == 2
                fprintf ('the total input is%8.4f\n',tin); 
                break
            end
        end
        if t >= tf
			break
        end
        tin = tin + 0.5*input*input'*dt;
    end
    
    fclose(fp);
    
    sat_plot;
    sat_movie;
    