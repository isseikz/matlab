function dx = car_func(x,input)
% car_func.m
% Equations of motion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    global length
    global accel_max delta_max fai_max
% clear state derivatives
    dx   = zeros(size(x));
% state variables    
    the = x(3);
    vel = x(4);
    fai = x(5);
% input variables
    accel = input(1);
    delta = input(2);
% limitation of input variables
    if accel > accel_max
        accel = accel_max;
    else if accel < -accel_max
            accel = -accel_max;
        end 
    end
    if delta > delta_max
        delta = delta_max;
    else if delta < -delta_max
        delta = -delta_max;
        end
    end
    if fai >= fai_max
        if delta > 0.0
            delta = 0.0;
        end
    else if fai <= -fai_max
        if delta < 0.0
            delta = 0.0;
        end
        end
    end
% equation of motion
    dx(1)   = cos(the) * vel;
    dx(2)   = sin(the) * vel;
    dx(3)   = tan(fai) / length * vel;
    dx(4)   = accel;
    dx(5)   = delta;


    
    
    