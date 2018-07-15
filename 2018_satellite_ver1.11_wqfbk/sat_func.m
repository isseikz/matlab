function dx = sat_func(x,input)
% sat_func.m
% Equations of motion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    global Inert torque_max

% clear state derivatives
    dx   = zeros(size(x));

% limitation of input variables
for i=1:3
    if input(i) > torque_max
        input(i) = torque_max;
    else if input(i) < -torque_max
            input(i) = -torque_max;
        end 
    end
end
  
%ó‘Ô—Ê
    omega = [x(1) x(2) x(3)];
    quart = [x(4) x(5) x(6) x(7)];
%“ü—Í—Ê
    Torque = [input(1) input(2) input(3)];
%ó‘Ô•û’öŽ®
    dx(1) = (Torque(1) - ( Inert(3) - Inert(2) ) * omega(2) * omega(3) ) / Inert(1);
    dx(2) = (Torque(2) - ( Inert(1) - Inert(3) ) * omega(3) * omega(1) ) / Inert(2);
    dx(3) = (Torque(3) - ( Inert(2) - Inert(1) ) * omega(1) * omega(2) ) / Inert(3);
    dx(4) = 0.5 * (  quart(4) * omega(1) - quart(3) * omega(2) + quart(2) * omega(3));  
    dx(5) = 0.5 * (  quart(3) * omega(1) + quart(4) * omega(2) - quart(1) * omega(3));
    dx(6) = 0.5 * (- quart(2) * omega(1) + quart(1) * omega(2) + quart(4) * omega(3));
    dx(7) = 0.5 * (- quart(1) * omega(1) - quart(2) * omega(2) - quart(3) * omega(3));

    
    
    