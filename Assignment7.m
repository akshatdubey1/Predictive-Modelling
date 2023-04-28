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
%c_rot = 0.001

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
%c_rot_2 = 0.001

k_lin = 30e6;             %[Nm],  linear stiffness
c_lin = 300;              %[Nms], linear damping
%c_lin = 0.001

syms s
s = tf('s');
w_lpf = 10*f_bw*2*pi;
%w_lpf = 3000;
lpf = 1/(1+s/w_lpf)
lpf = 1;


%%

xs = 0;
x1 = 250e-3+xs;
x2 = 250e-3-xs;
gain = x2/x1;
com = (m2*0 + m3*x2 + m4*(x2+x1))/(m2+m3+m4);
icom = (2*d2)-com;


d2_1 = x1;
d2_2 = x2;

if gain == 1
    ForceGain1 = 1;
    ForceGain2 = 1;

elseif gain < 1
    ForceGain1 = com/icom;
    ForceGain2 = 1;
else 
    ForceGain1 = 1;
    ForceGain2 = icom/com;
end
