% Modal analysis CD-head

% Mass matrix
M1 = 3e-4; % [kg] focus coil
M2 = 5e-4; % [kg] radial coil
M3 = 2e-4; % [kg] lens

M = [
    M1 0  0;
    0  M2 0;
    0  0  M3];

% Stiffness matrix
freq1 = 40; % [Hz] eigenfreq lensassy;

K02 = (2*pi*freq1)^2 * (M2+M1+M3);
K12 = 0.2e6; % [N/m]
K23 = 1.0e6; % [N/m]
%K23 = K12*((((M3)*(freq1*2*pi)^2))/(((M1)*(freq1*2*pi)^2)))

K = [
      K12 -K12           0;
     -K12 (K02+K12+K23) -K23;
      0   -K23           K23];

% Determine eigenvectors, eigenvalues 
[V,D] = eig(K,M);
D = diag(D);
n = size(V);

%test of plotting the mode shapes
%mode1
figure
V=V.*-1;
subplot(1,3,1)
plot([V(1,3) 0],[1 1]); hold on
plot([V(1,2) 0],[2 2]); hold on
plot([V(1,1) 0],[3 3]); hold on
plot([0 0],[4 0])
xlim([-50,50])
ylim([0,4])
yticks([1,2,3])
yticklabels(["13 kHz - 1", "5 kHz - 2", "40 Hz - 3"])
xticks([])
title("Focus coil")
subplot(1,3,2)
plot([V(2,3) 0],[1 1]); hold on
plot([V(2,2) 0],[2 2]); hold on
plot([V(2,1) 0],[3 3]); hold on
plot([0 0],[4 0])
xlim([-50,50])
ylim([0,4])
yticks([1,2,3])
xticks([])
title("Radial coil")
subplot(1,3,3)
plot([V(3,3) 0],[1 1]); hold on
plot([V(3,2) 0],[2 2]); hold on
plot([V(3,1) 0],[3 3]); hold on 
plot([0 0],[4 0])
xlim([-50,50])
ylim([0,4])
yticks([1,2,3])
xticks([])
title("Lens")



% % Scale to max norm to bring the mass matrix to 'realistic' values
 %for i=1:n(2)
 %    V(:,i) = V(:,i)/max(V(:,i));
 %end

V=V.*-1;
% Eigenvalues to eigenfrequencies
D = sqrt(D)/(2*pi);

% Reduced modal mass and stiffness matrices

MM = V'*M*V;
KK = V'*K*V;

% Take the diagonal elements

MM = diag(MM);
KK = diag(KK);

% Modal damping
zeta = 0.01;
CC = 2*zeta*sqrt(MM.*KK);

% Transfer from Force point A to Displacement point B
A = 2;
B = 3;
for i=1:n(2)
    mode(i) = tf([V(A,i)*V(B,i)],[MM(i) CC(i) KK(i)]);
end

% Plot response
%figure(2); 
%bode( mode(1), mode(2), mode(3), logspace(1,5,1000)*2*pi);
%legend("mode 1", "mode 2", "mode 3")


%figure(3); 
%bode( mode(1), 'r', mode(2), 'r', mode(3), 'r', mode(1)+mode(2)+mode(3), 'k', logspace(1,5,1000)*2*pi);
%legend("mode 1", "mode 2", "mode 3", "combined modes")

