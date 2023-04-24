%%Setup of the system
%Step properties
step_size = 20e-3;       % [m],  step size
step_time = 200e-3;      % [s],  step time
m1=20;                   % [kg], moving mass in y
F=40;                    % [N],  max fore per actuator

%Model setup
m2 = 5;                  %[kg], left mass, linear motor
m3 = 10;                 %[kg], center mass, stage
m4 = 5;                  %[kg], right mass, linear motor    

k_rot = 2e4;             %[Nm/rad],  rotational stiffness
c_rot = 2;               %[Nms/rad], rotational damping

I1 = 0.1;                %[kgm2], moment of inertia of the stage
I2 = 0.02;               %[kgm2], moment of inertia of the stage motors

d1 = 25e-3;              %[m], distance from center of m3 to sensor
d2 = 250e-3;             %[m], distance from middle of m3 to m2 and m4


%% Q3
% P controller
f_bw = 100;              %[Hz], bandwidth of the controller

[P, I, D, N, Kp] = PIDcode(f_bw,m1);


% Q12

m5 = 5;                  %[kg], masses in part 5  

k_rot_2 = 10^6;          %[Nm/rad],  rotational stiffness
c_rot_2 = 5;             %[Nms/rad], rotational damping


k_lin = 30e6;             %[Nm],  linear stiffness
c_lin = 300;              %[Nms], linear damping

syms s
s = tf('s');
w_lpf = 10*f_bw*2*pi;
%w_lpf = 3000;
lpf = 1/(1+s/w_lpf)
lpf = 1;
