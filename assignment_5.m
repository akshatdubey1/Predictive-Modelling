%Script for assignment 5

%%
%Define properties of the first simmechanics simulation

M1 = 990; %Base mass,kg
M2 = 10;  %Floating mass, kg
M_t = M1+M2; %Total mass, kg
Step = 20e-3;%Step set point signal, m
step_t = 200e-3;%Step signal start

%Error comparison
e_comp = 0.1e-6;%Allowable error, m
%Setting comparison
t_settlecomp = 200e-3; %Maximum settling time, s

%PID controller
f_bw = 80; %Bandwidth of controller, Hz
w_bw = 2*pi*f_bw;

%Defining P value
Kp = (2*pi*f_bw)^2*M2;

%Defining D value
f_d = f_bw/3;
w_d = 2*pi*f_d;
T_d = 1/w_d; 

%Defining taming action (N)
f_t = f_bw*3;
w_t = 2*pi*f_t;
T_t = 1/w_t;

%Defining I value
f_i = f_bw/10;
w_i = 2*pi*f_i;
T_i = 1/w_i;


%Limiting the actuator

F_max = 40; %Max force of actuator, N
t_max = 2e-3; %Fastest speed of max force, s


%Calculating the required acceleration

%Step 
%

d_step = 20e-3; %size of step, m
t_step = 0.1; %time of step, s
a_step = (d_step)/(t_step^2); %acceleration of step, m/s^2




