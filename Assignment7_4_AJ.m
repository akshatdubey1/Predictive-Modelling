
syms t s
syms y_1(t) y_2(t) y_3(t) 
syms Y_1(s) Y_2(s) Y_3(s) 
syms y_dot_1(t) y_dot_2(t) y_dot_3(t)
syms y_ddot_1(t) y_ddot_2(t) y_ddot_3(t)
% syms x_1 x_2 x_3 
% syms x_dot_1 x_dot_2 x_dot_3
% syms x_ddot_1 x_ddot_2 x_ddot_3
syms F_1 F_1_Y(s)
syms F_2 F_2_Y(s)
%Displacements
y = [y_1, y_2].';
yd = [y_dot_1, y_dot_2].';
ydd = [y_ddot_1, y_ddot_2].';


%%Setup of matrix
m=20;                    % [kg], moving mass in y
k = 2e4;                 %[Nm/rad],  rotational stiffness
c = 2;                   %[Nms/rad], rotational damping
J = 0.1;                 %[kgm2], moment of inertia of the stage
a1 = 250e-3;             
a2 = 250e-3;             
s1 = 25e-3;              
s2 = 25e-3;             


M=[m 0;
   0 J];
C=[0 0;
   0 c];
K=[0 0;
   0 k];
F=[1 1;
   -a1 a2];
T=[1 -s1;
   1 s2];

M_mod = inv(F)*M*inv(T);
C_mod = inv(F)*C*inv(T);
K_mod = inv(F)*K*inv(T);


EOM = M_mod*ydd+C_mod*yd+K_mod*y;

 F = [F_1 F_2].';
 Fs = [F_1_Y(s) F_2_Y(s)].';
% disp('Equations of motion are ')
 EOM == F;
% %Input values into respective matrices and EOMs
% M = double(subs(M,data,[500 2 3 1E8 5E7 6E4 2E2 1E3]));
% K = double(subs(K,data,[500 2 3 1E8 5E7 6E4 2E2 1E3]));
% C = double(subs(C,data,[500 2 3 1E8 5E7 6E4 2E2 1E3]));
% EOM = subs(EOM,data,[500 2 3 1E8 5E7 6E4 2E2 1E3]);
% disp('Equations of motion(with values) are ')
% EOM == F
 Y = [y_1(t), y_2(t)].';
 DY = [diff(y_1(t),t) diff(y_2(t),t)].';
 DDY =[diff(y_1,t,2) diff(y_2(t),t,2)].';
 DiffT = vertcat(Y,DY,DDY);
 
 Ys = [Y_1(s),Y_2(s)].'; 
 Y_L = [laplace(y_1(t),t,s),laplace(y_2(t),t,s)];
 Y_0 = subs(DiffT,t,0);

 q = [y_1,y_2,y_dot_1,y_dot_2,y_ddot_1,y_ddot_2].';
 EOM = subs(EOM,q,[DiffT])
 EOM_L = laplace(EOM)
%  
  EOM_L = subs(EOM_L,Y_L,[Y_1(s),Y_2(s)]);
  EOM_L = subs(EOM_L,Y_0, [0 0 0 0 0 0]') % initial condition zero
% 
eqns = EOM_L == Fs
%Split into matrices
[EOM_M,F]=equationsToMatrix(eqns,[Y_1(s),Y_2(s)]);
%Solve for Xs
%F = subs(F,[F_1_Y(s) F_2_Y(s)],[100 100])
Ys = inv(EOM_M)*F

Ys = simplify(Ys);

% %Retrieve numerator and denominator for transfer functions
force = [40 39]
%Ys = simplify(Ys)
n1 = [force(1)*9-force(2)*1 force(1)*80+force(2)*80  force(1)*800000+force(2)*800000];
n2 = [force(1)*9-force(2)*1 force(1)*80+force(2)*80  force(1)*800000+force(2)*800000];
d1 = force(1).*[80 160 80*200000 0 0];
d2 = force(2).*[80 160 80*200000 0 0];

% %Collect numerator and denominator terms

% %% Transfer functions
sys1 = tf(n1,d1); %Fx to x1
sys2 = tf(n2,d2); %Fx to x2

figure;
step(sys1,sys2)
figure;
bode(sys1)
% 
% [n, d] = numden(Ys);
% n1 = sym2poly(n(1));
% n2 = sym2poly(n(2));
% 
% d1 = sym2poly(d(1));
% d2 = sym2poly(d(2));
% 
% sys1 = tf(n1,d1); %Fx to x1
% sys2 = tf(n2,d2); %Fx to x2
% figure;
% 
% step(sys1,sys2)
