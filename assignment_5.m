%Script for assignment 5
clear all
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
zeta = 0.008;
b = zeta*2*sqrt(Kp*M2);

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
Rate_limit = F_max/t_max;

%% 
%Q5 error evaluation
Q5_error=load("Error_Q5.mat"); %Load file
error_time5 = squeeze(Q5_error.ans.Time); %Eliminate extra dimension of array
error_time5 = round(error_time5,4); %Round the number to help find function
error_time_350 = find(error_time5 == 0.3500); %Find the index of 0.3500
error_time_350 = error_time_350(1); %First 350ms index
error_data5 = squeeze(Q5_error.ans.Data); %Eliminate extra dimension of array
error_data_350 = error_data5(error_time_350); %Error corresponding to time 0.3500





Q5_error_data = squeeze(Q5_error.ans.Data);
time = Q5_error.ans.Time;

figure;
plot(time,Q5_error_data)
axis([0 1 -40e-6 20e-6])
title("Error of the system")
xlabel("Time (s)")
ylabel("Amplitute (m)")


%% 

%Q6 error evaluation
q6_error = load('q6_error.mat'); %Load file
error_time6 = squeeze(q6_error.ans.Time); %Eliminate extra dimension of array
error_time6 = round(error_time6,4); %Round the number to help find function
error_time_350 = find(error_time6 == 0.3500); %Find the index of 0.3500
error_time_350 = error_time_350(1); %First 350ms index
error_data6 = squeeze(q6_error.ans.Data); %Eliminate extra dimension of array
error_data_350 = error_data6(error_time_350); %Error corresponding to time 0.3500


time = q6_error.ans.Time;

figure;
plot(time,error_data6); hold on;

Q6_error=load("q6_error.mat");
Q6_error_data = squeeze(Q6_error.ans.Data);

time = Q6_error.ans.Time;

plot(time,Q6_error_data); hold on;
Error_line = xline(0.35);

[xint,yint] = intersections([0.35 0.35],[0 100],time,Q6_error_data);

axis([0 0.5 -40e-6 20e-6])
title("Error of the system")
xlabel("Time (s)")
ylabel("Amplitute (m)")


%% 





%Calculating the required acceleration

%Step 
%

d_step = 20e-3; %size of step, m
t_step = 0.1; %time of step, s
v_step = (d_step)/(t_step); %velocity of step, m/s
a_step = (d_step)/(t_step^2); %acceleration of step, m/s^2
%j_step = (d_step)/(t_step^3); %jerk of step, m/s^3
j_step = 2000;

%jerk profile generation using make3.m
[t,jd] = make3(d_step,v_step,a_step,j_step);
%% 

%Q7 error evaluation

%For 100%
q7_error_100 = load('q7_error_100.mat'); %Load file
error_time_100 = squeeze(q7_error_100.ans.Time); %Eliminate extra dimension of array
error_time_100 = round(error_time_100,4); %Round the number to help find function
error_time_350 = find(error_time_100 == 0.3500); %Find the index of 0.3500
error_time_350 = error_time_350(1); %First 350ms index
error_data_100 = squeeze(q7_error_100.ans.Data); %Eliminate extra dimension of array
error_data_350_100 = error_data_100(error_time_350); %Error corresponding to time 0.3500

%For 99%
q7_error_99 = load('q7_error_99.mat'); %Load file
error_time_99 = squeeze(q7_error_99.ans.Time); %Eliminate extra dimension of array
error_time_99 = round(error_time_99,4); %Round the number to help find function
error_time_350 = find(error_time_99 == 0.3500); %Find the index of 0.3500
error_time_350 = error_time_350(1); %First 350ms index
error_data_99 = squeeze(q7_error_99.ans.Data); %Eliminate extra dimension of array
error_data_350_99 = error_data_99(error_time_350); %Error corresponding to time 0.3500

%For 90%
q7_error_90 = load('q7_error_90.mat'); %Load file
error_time_90 = squeeze(q7_error_90.ans.Time); %Eliminate extra dimension of array
error_time_90 = round(error_time_90,4); %Round the number to help find function
error_time_350 = find(error_time_90 == 0.3500); %Find the index of 0.3500
error_time_350 = error_time_350(1); %First 350ms index
error_data_90 = squeeze(q7_error_90.ans.Data); %Eliminate extra dimension of array
error_data_350_90 = error_data_90(error_time_350); %Error corresponding to time 0.3500

figure;
plot(error_time_100,error_data_100); hold on;
plot(error_time_99,error_data_99); hold on;
plot(error_time_90,error_data_90); 
axis([0 0.5 -4e-6 2e-6])
title("Error of the system")
xlabel("Time (s)")
ylabel("Amplitute (m)")
legend("100% correct", "99% correct", "90% correct")


%%
%q9 
x_dist = 200e-6; %amplitude of disturbance from fixed world to the frame, m
f_dist = 3; %natural frequency of the system that connects frame to the fixed world, Hz
w_dist = 2*pi*f_dist;%f_dist, rad/s
x_error = 0.1e-6; %amplitude of allowed error, m

%calculating stiffness between world and frame
K1 = M1*(w_dist^2); %stiffness between world and the frame

%finding the bandwidth
f_bw = f_dist*sqrt((x_dist/x_error));

%adding damping 
zeta_world = 0.15;
C1 = 2*zeta_world*sqrt(K1*M1);

%q12

M1 = 840; 
x_dist = 200e-6; %amplitude of disturbance from fixed world to the frame, m
f_dist = 3; %natural frequency of the system that connects frame to the fixed world, Hz
w_dist = 2*pi*f_dist;%f_dist, rad/s
x_error = 0.1e-6; %amplitude of allowed error, m

%calculating stiffness between world and frame
K1 = M1*(w_dist^2); %stiffness between world and the frame

%finding the bandwidth
f_bw = f_dist*sqrt((x_dist/x_error));
%% 

%adding damping 
zeta_world = 0.15;
C1 = 2*zeta_world*sqrt(K1*M1);
%calculating the stiffness and damping for interferometer
M_int = 100;
f_int = 230;
w_int = 2*pi*f_int;
K2 = M_int*(w_int^2);
zeta_int = 0.01;
C2 = 2*zeta_int*sqrt(K2*M_int);

%calculating the stiffness and damping for motor
M_mot = 50;
f_mot = 200;
w_mot = 2*pi*f_mot;
K3 = M_mot*(w_mot^2);
zeta_mot = 0.005;
C3 = 2*zeta_mot*sqrt(K3*M_mot);

%redefine the PID controller
%f_bw = 75; %uncomment to redefine

%PID controller
%Defining P value
Kp = ((2*pi*f_bw)^2*M2)/3;

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


%Adding LPF
syms s
s = tf('s');
f_lpf = 5*f_bw;
w_lpf = 2*pi*f_lpf;
lpf = 1/(1+s/w_lpf);


