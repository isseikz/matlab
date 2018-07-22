function [input] = car_control(pos, the, vel, fai, target, length, t);
% car_control.m
% input program
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% design the control law here
% input(1) is the accelaration[m/s^2]
% input(2) is the delta[deg/s]

global casenumber
global ctr_S ctr_c ctr_Lambda ctr_input ctr_state_p ctr_lambda_Traj
global accel_max delta_max fai_max

ctr_Tf   = 5; 
ctr_T_a  = 0.5;
ctr_T    = ctr_Tf * (1-exp(-ctr_T_a*t));
ctr_step = 500;
ctr_dt   = ctr_T / ctr_step;
ctr_dTdt = -ctr_T_a * ctr_Tf * exp(-ctr_T_a*t);

ctr_Q0 = [[1,0,0,0,0];[0,1,0,0,0];[0,0,1,0,0];[0,0,0,1,0];[0,0,0,0,1]];
ctr_Q = [[100,0,0,0,0];[0,1000,0,0,0];[0,0,1,0,0];[0,0,0,1,0];[0,0,0,0,10]];
ctr_R = [[100,0];[0,10000]];
ctr_state = [pos(1), pos(2), the, vel, fai]';
% disp([t,ctr_state']);

ctr_A1 = -100 * eye(5);

if t == 0 % initial condition
    ctr_Lambda = func_dPhidx(ctr_Q0, ctr_state);
    
    ctr_Trajectory = zeros(5,ctr_step);
    ctr_lambda_Traj = zeros(5,ctr_step);
    ctr_input = zeros(2,ctr_step);
    
    ctr_state_p = ctr_state;
    for i = 1:ctr_step
        ctr_input(:,i) = func_inputs(ctr_Q0, ctr_Lambda);
        ctr_lambda_Traj(:,i) = ctr_Lambda;
    end
end

if t > 0 % Update costate: lambda
    ctr_Trajectory(:,1) = ctr_state_p;
    ctr_lambda_Traj(:,ctr_step) = func_dPhidx(ctr_Q, [0,0,90.0 * pi / 180.0,0,0]');
    ctr_state_p = ctr_state;
%     
    for i = 1:ctr_step
        ctr_Trajectory(:,i+1) = ctr_Trajectory(:,i) + func_f(ctr_state, ctr_input(:,i)) * ctr_dt;
    end
    for i = 1:ctr_step-1
        ctr_lambda_Traj(:,ctr_step-i) = ctr_lambda_Traj(:,ctr_step-i+1) - func_dHdx(ctr_Q, ctr_Trajectory(:,ctr_step-i+1), ctr_lambda_Traj(:,ctr_step-i+1))' * ctr_dt;
    end
    disp(ctr_Trajectory(1:2,:));
% %     pause
%     
    dHdx = func_dHdx(ctr_Q, ctr_state_p,func_dPhidx(ctr_Q, ctr_lambda_Traj(:,ctr_step)));
    d2Phidx2= func_d2Phidx2(ctr_Q);
    f =func_f(ctr_state_p, ctr_input(:,ctr_step));
    dPhidx0= func_dPhidx(ctr_Q0, [0,0,90.0 * pi / 180.0,0,0]');
    dPhidx = func_dPhidx(ctr_Q, ctr_Trajectory(:,ctr_step));
%     disp(dPhidx0-dPhidx);
    
    ctr_S = func_d2Phidx2(ctr_Q);
    ctr_c = (dHdx + d2Phidx2 *f)*ctr_dTdt + ctr_A1*(dPhidx0-dPhidx);
    
    ctr_A  = func_dFdx(ctr_state_p) -func_dFdu() *(func_d2Hdu2(ctr_R) \func_d2Hdudx());
    ctr_B  = func_dFdu() * (func_d2Hdu2(ctr_R) \func_dFdu()');
    ctr_C  = func_d2Hdx2(ctr_Q, ctr_state_p, ctr_Lambda) - func_d2Hdudx()' * (func_d2Hdu2(ctr_R) \ func_d2Hdudx());

    ctr_dSdTau =  -ctr_A'*ctr_S - ctr_S * ctr_A +ctr_S *(ctr_B * ctr_S) - ctr_C;
    ctr_dcdTau = -(ctr_A' - ctr_S * ctr_B) * ctr_c;

    for i = 1:ctr_step
        ctr_S = ctr_S - ctr_dSdTau * ctr_dt;
        ctr_c = ctr_c - ctr_dcdTau * ctr_dt;
    end
    
    ctr_dLambdadt = ctr_S * func_f(ctr_state_p, ctr_input(:,1)) + ctr_c;
    ctr_Lambda = ctr_Lambda + ctr_dLambdadt * 0.01;

    for i = 1:ctr_step
        ctr_input(:,i) = func_inputs(ctr_R, ctr_Lambda);
    end
end

% input = f(lambda)
input(1) = ctr_input(1,1);
input(2) = ctr_input(2,1);