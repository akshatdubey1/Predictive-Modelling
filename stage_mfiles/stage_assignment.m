%% Main Stage script
clear all
close all

% Stage (default) properties
M1 = 10; % [kg] mirror assy
J1 = 0.05; % [kg m^2/rad]
M2 = 5; % [kg] motor assy
J2 = 0.025; % [kg m^2/rad]

% coordinate system [X1 Y1 F1 X2 Y2 F2]

k1 = 22.5e6; % [N/m] vertical spring connecting mirror & motor
k2 = 17e6; % [N/m] vertical spring motor & world
k3 = 19e6; % [N/m] horizontal spring connecting mirror & motor

d = 0.08; % [m] horizontal separation of springs
b = 0.09; % [m] vertical separation of CoGs



%Optimal system 
a=0.00
F = 0.12815; % [m] vertical position of force relative to motor CoG
o = 0.14575-0.09

%original settings
a = 0 
F=0.06;
o=0.03;
stage_modes;

stage_transfer;

%%
mode = 4;
stage_mode_animation;

%% 

%a = 5.17/90;  % [-] ratio of horizontal spring position 
% a=0: spring through motor CoG, a=1: spring through mirror CoG

%System where the force is at the place where the bottom block rotates and
%the sensor is where the top block rotates
%a=0.01
%F=0.1275
%o=-0.9+0.0576

%a=0.01
%F=0.1275
%o=0.05760
%o = -0.9-0.05 % [m] vertical position of observer relative to mirror CoG


