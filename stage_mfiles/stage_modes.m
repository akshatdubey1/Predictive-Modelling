%% Stage Modes

% Define Mass and Stiffness matrix of the system,
% Body 1: Upper body (mirror assy)
% Body 2: Lower body (motor assy)

M = [
    M1 0  0  0  0  0;
    0  M1 0  0  0  0;
    0  0  J1 0  0  0;
    0  0  0  M2 0  0;
    0  0  0  0  M2 0;
    0  0  0  0  0  J2];

% Stiffness matrix

% V11 = k1*((y1-d*f1)-(y2-d*f2))
% V12 = k1*((y1+d*f1)-(y2+d*f2))
% V1 = V11+V12 = 2*k1*(y1-y2)
% M1 = d*(V12-V11) = 2*k1*d^2*(f1-f2)

K1 = 2*k1 * [ 0  0    0  0  0    0;
              0  1    0  0 -1    0;
              0  0  d^2  0  0 -d^2;
              0  0    0  0  0    0;
              0 -1    0  0  1    0;
              0  0 -d^2  0  0  d^2];

% V21 = k2*((y2-d*f2)-0)
% V22 = k2*((y2+d*f2)-0)
% V2 = V21+V22 = 2*k2*y2
% M2 = d*(V22-V21) = 2*k2*d^2*f2
          
K2 = 2*k2 * [ 0  0  0  0  0    0;
              0  0  0  0  0    0;
              0  0  0  0  0    0;
              0  0  0  0  0    0;
              0  0  0  0  1    0;
              0  0  0  0  0  d^2];
          
% H = k3*((x2-a*b*f2)-(x1+(1-a)*b*f1))
% M1 = -(1-a)*b*H
% M2 = -a*b*H
          
K3 = k3 * [ 1       0  b*(1-a)     -1        0  b*a;
            0       0  0            0        0  0;
            b*(1-a) 0  b^2*(1-a)^2 -b*(1-a)  0  b^2*a*(1-a);
           -1       0 -b*(1-a)      1        0 -b*a;       
            0       0  0            0        0  0;
            b*a     0  b^2*a*(1-a) -b*a      0  b^2*a^2];
        
K = K1 + K2 + K3;

% Determine eigenvectors, eigenvalues 
[V,D] = eig(K,M,'vector');
n = numel(D);

% Eigenvalues to eigenfrequencies
D = sqrt(D)/(2*pi);

% Reduced modal mass and stiffness matrices

MM = V'*M*V;
KK = V'*K*V;

% Take the diagonal elements

MM = diag(MM);
KK = diag(KK);

% Modal damping
zeta = 0.005;
CC = 2*zeta*sqrt(MM.*KK);
