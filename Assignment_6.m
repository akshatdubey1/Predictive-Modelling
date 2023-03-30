%%Assignment 6

%Part 1
M1=15  %Mass of the stage, kg
K1=17e6  %Stiffness of stage, N/m
C1=160  %Damping of stage, Ns/m
I=0.1  %Inertia kgm2/rad
x_stroke=250e-3; %stroke 


%% 
%Part 2

%Actuator block
M1=5;           %Mass, kg
K1=17E6;        %Stiffness, N/m
C1=160;         %Damping, Ns/m
I1=0.025;       %Moment of inertia, kgm2/rad
%Mirror block
M2=10;          %Mass, kg
K2=22.5E6;      %Stifness, N/m
C2=150;         %Damping, Ns/m
I2=0.05;        %Moment of inertia, kgm2/rad
%Connection of the bodies
K3=19E6;        %Stiffness, N/m
C3=75;          %Damping, Ns/m

