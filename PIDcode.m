function [P, I, D, N, Kp] = PIDcode(f_bw,M)

%f_bw is the bandwidth
%M is the mass of the controller mass
%Gives the values to be inputted into the ideal form of PID in the simulink
%block PID


%Proportional action
Kp = ((2*pi*f_bw)^2*M);
%Derivative action
f_d = f_bw/3;
w_d = 2*pi*f_d;
T_d = 1/w_d;
%Taming action
f_t = f_bw*3;
w_t = 2*pi*f_t;
T_t = 1/w_t;
%Integral action
f_i = f_bw/10;
w_i = 2*pi*f_i;
T_i = 1/w_i;


%%PID controller parameters for IDEAL form in Simulink
P = Kp/3;
I = 1/T_i;
D = T_d;
N = 1/T_t;