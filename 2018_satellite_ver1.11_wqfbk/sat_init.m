function [] = sat_init
% sat_init.m
% initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
global t x
global dt tf
global Inert torque_max
global casenumber tin
global flag target_1 target_2 target_3
%
% state variables
x       = zeros(10,1);   %10states
t       = 0;             %time
flag    = 1;

%������ԁ{�ړI�n1
switch casenumber
    case 1  %case for minimum time
        disp('Case1:minimum time');
     
     %�����l
        x(1:3)  = [ 0; 0; 0];   %angular velocity
        x(4:7)  = [ 0; 0; 0; 1];  %quaternion1-4   

% % �����_���ڕW�̂��߂̃R�����g�A�E�g
%         
%      %�ڕW�l�Htarget = [ q1, q2, q3, q4]
        target_1 = [ 0.5000, 0.5000, 0.5000, 0.5000]; 
        target_2 = [ 0.353553390593274, 0.853553390593274, -0.353553390593274, -0.146446609406726];
        target_3 = [ 0.191341716182545, 0.461939766255643, 0.331413574035592, -0.800103145191265];  
       
    case 2  %case for minimum input
        disp('Case2:minimum input');
        
      %�����l
        x(1:3)  = [ 0; 0; 0];   %angular velocity
        x(4:7)  = [ 0; 0; 0; 1];  %quaternion1-4
        
% % �����_���ڕW�̂��߂̃R�����g�A�E�g
%           
%       %�ڕW�l�Htarget = [ q1, q2, q3, q4]
        target_1 = [ 0.5000, 0.5000, 0.5000, 0.5000];
        target_2 = [ 0.353553390593274, 0.853553390593274, -0.353553390593274, -0.146446609406726];
        target_3 = [ 0.191341716182545, 0.461939766255643, 0.331413574035592, -0.800103145191265];       
        
end
% sat parameter
Inert = [20.0; 20.0; 20.0];
torque_max = 10.0;
tin = 0.0;
% simulation parameter
dt     = 0.01;          %simulation step[s]
tf     = 20.0;          %simulation duration[s]
