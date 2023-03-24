%%Assignment 6

M1=15  %Mass of the stage, kg
K1=17e6  %Stiffness of stage, N/m
C1=160  %Damping of stage, Ns/m
I=0.1  %Inertia kgm2/rad




%PID controller
%w_bw=sqrt(K1/M1);
%f_bw=w_bw/(2*pi)
f_bw = 63; %Bandwidth of controller, Hz
w_bw = 2*pi*f_bw;

%Defining P value
Kp = (2*pi*f_bw)^2*M1;

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

