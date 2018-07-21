function [] = car_evaluate
%UNTITLED この関数の概要をここに記述
%   詳細説明をここに記述

    global t x
    global length
    global dt tf
    global tgx tgy tgthe
    global v_max delta_max fai_max
   
    target_radius = 0.5; %[m]
    target_angle  = 5.0; %[deg]
    target_vel    = 1.0; %[m/s]
    
    i=5;
    for n = 1:i
        if (x(1)-length*cos(x(3)))^2 + (x(2)-length*sin(x(3)))^2 <= target_radius^2.0
            if abs(x(4)) <= target_vel
                if   (90.0*(2*n-1)-target_angle) * pi /180 <=x(3) && x(3) <=  (90.0*(2*n-1)+target_angle) * pi /180
                    tf = t;
                    J  = tf;
                elseif  -(90.0*(2*n-1)-target_angle) * pi /180 >=x(3) && x(3) >= -(90.0*(2*n-1)+target_angle) * pi /180
                    tf = t;
                    J  = tf;
                end
            end
        end
    end
end

