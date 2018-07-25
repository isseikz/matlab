function limited_input = func_limited_input(input)

    global accel_max delta_max
    
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
    
    limited_input(1) = accel;
    limited_input(2) = delta;