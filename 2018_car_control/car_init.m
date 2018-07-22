function [] = car_init
% car_init.m
% initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    global t x
    global length
    global dt tf
    global tgx tgy tgthe
    global accel_max delta_max fai_max
    global casenumber
%
% state variables
    x       = zeros(6,1);   %6states
    t       = 0;            %time
    
    %�������1~4�i������ς���̂��ۑ�j�A5,6
    switch casenumber
        case 1
            disp('Case1');
                x(1:2)  = [ -0; -100];   %position[m]
                x(3)    = 90.0 * pi / 180.0;  %attitude[deg]
                x(4)    = 0.0;                %velocity[m/s]
                x(5)    = 0.0 * pi / 180.0;   %steering[deg]
        case 2
            disp('Case2');
                x(1:2)  = [ -100; 0];   %position[m]
                x(3)    = 0.0 * pi / 180.0;  %attitude[deg]
                x(4)    = 0.0;                %velocity[m/s]
                x(5)    = 0.0 * pi / 180.0;   %steering[deg]
        case 3
            disp('Case3');
                x(1:2)  = [ 0; 0];   %position[m]
                x(3)    = 0.0 * pi / 180.0;  %attitude[deg]
                x(4)    = 0.0;                %velocity[m/s]
                x(5)    = 0.0 * pi / 180.0;   %steering[deg]            
        case 4 %%%%%�����_��������Ԃ̓}�j���A������%%%%%
            disp('Case4');
                x(1:2)  = [ 0; -100];   %position[m]
                x(3)    = 90.0 * pi / 180.0;  %attitude[deg]
                x(4)    = 0.0;                %velocity[m/s]
                x(5)    = 0.0 * pi / 180.0;   %steering[deg]
    end
    
    x(6)    = 0.0;          %accelaration[m/ss]
    x(7)    = 0.0 * pi / 180.0;   %steering[deg/s]
% car parameter
    length  = 2.0;          %length[m]
    accel_max   = 10.0;         %max|accel| [m/s]
    delta_max   = 5.0 * pi / 180.0; %max|delta| [deg/s]
    fai_max = 10.0 * pi / 180.0; %max|fai|[deg]
% simulation target
    tgx     = 0.0;          %x[m]
    tgy     = 0.0;          %y[m]
    tgthe   = 90.0 * pi / 180.0;  %attitude[deg]
% simulation parameter
    dt     = 0.01;          %simulation step[s]
    tf     = 20.0;          %simulation duration[s]
    