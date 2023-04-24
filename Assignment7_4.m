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

