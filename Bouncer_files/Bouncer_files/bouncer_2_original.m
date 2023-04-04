clear all; close all; clc
% This file will load the modal data from the COMSOL model. It will then
% plot the transfer from the actuator location to one of the nodes on the
% sensor block, in Z-direction. You can choose some different nodes on the
% sensor block and combine them to obtain the rotation of the sensor block
% in the YZ-plane.

%% load modal data
% These text files contain the modal data as extracted from the COMSOL
% model. Beware that the first column of these matrices contains to modal
% frequencies (in Hz). To get the displacement in X,Y or Z of the nodes
% on the sensor block, you need to take colum 'node-number+1', with node
% numbers as indicated in the figure.
% ModalMasses = load ('nyitt_ModalMasses.txt');
% dispXactuator = load ('nyitt_dispXactuator.txt');
% dispXsensor1 = load ('nyitt_dispXsensor1.txt');
% dispXsensor2 = load ('nyitt_dispXsensor2.txt');
% dispXsensor3 = load ('nyitt_dispXsensor3.txt');
% dispYsensor1 = load ('nyitt_dispYsensor1.txt');
% dispYsensor2 = load ('nyitt_dispYsensor2.txt');
% dispYsensor3 = load ('nyitt_dispYsensor3.txt');
% dispZsensor1 = load ('nyitt_dispZsensor1.txt');
% dispZsensor2 = load ('nyitt_dispZsensor2.txt');
% dispZsensor3 = load ('nyitt_dispZsensor3.txt');

ModalMasses = load('ModalMasses.txt');
dispXactuator = load('dispXactuator.txt');
dispXsensor = load('dispXsensor.txt');
dispYsensor = load('dispYsensor.txt');
dispZsensor = load('dispZsensor.txt');

%For Nytt
%s1 - :,2
%s2 - :,4
%s3 - :,2

%%
n = size(ModalMasses,1);        % number of modes
f = ModalMasses(:,1);           % eigen frequencies
m = ModalMasses(:,2);           % modal masses
k = m.*(f*2*pi).^2;             % modal stiffnesses
Q = 2e2;                        % quality factor of resonances
c = sqrt(m.*k)/Q;               % damping

% displacement in X of actuator block: you can take the average of the two
% points measured and 

Xa = sum(dispXactuator(:,2:3),2)/2;

% displacement in Z of measurement node. In this case I took node 1, with
% the data provided you can choose different nodes, and by combining them
% you can obtain rotations in the YZ plane.

% Z1 = dispZsensor1(:,2);
% Y1 = dispYsensor1(:,2);
% X2 = dispXsensor2(:,4);
% Z3 = dispZsensor3(:,2);
% Y3 = dispYsensor3(:,2);


% rot1 = (-(atan(Z1./Y1)));
% rot3 = (atan(Z3./Y3));
% 
% diff_rot = rot1+rot3;


%Zs = dispXsensor(:,4); %Zs is the final variable that the calculated displacement should be equated to 
Zs =  dispZsensor(:,2);
%%

% calculate effective masses and stiffnesses. These can become negative due
% to the movement of the actuator and sensor point being out of phase.
m_eff = m./(Xa.*Zs);            % effective modal mass
k_eff = k./(Xa.*Zs);            % effective modal stiffness
c_eff = c./(Xa.*Zs);            % effective damping

% m_eff = m./(Xa.*Xa);
% k_eff = k./(Xa.*Xa);            % effective modal stiffness
% c_eff = c./(Xa.*Xa);            % effective damping

p = bodeoptions;
p.Grid = 'on';
p.FreqUnits = 'Hz';
p.MagUnits = 'abs';
p.MagScale = 'log';
p.XLim = {[0,10]};

%% calculate modal masses
for i = 1:n
    if i == 1;
        M(i) = tf(1,[m(i) 0 0]);
    else
        M(i) = tf(1,[m(i) c(i) k(i)]);
    end
end
%% Plot tranfer
f1 = figure(1); hold on;              
for i = 1:n
    bodeplot(M(i), 'm', p);        % plot modal transfer
end
title('All modes');

%% Calculate norm
for i = 1:n
   normM(i) = norm( M(i), 2);
%     normM(i) = norm( M(i), inf);
end

%% Plot tranfer attenuated with actuator arm
f1 = figure(2); hold on;
for i = 1:n
    bodeplot(Xa(i)*M(i), 'm', p);        % plot modal transfer
end
title('All modes attenuated with actuator arm');

%% Plot tranfer attenuated with actuator and sensor arm
f1 = figure(3); hold on;
P = tf(0,1);
for i = 1:n
    bodeplot(Zs(i)*Xa(i)*M(i), 'm', p);        % plot modal transfer
    P = P + Zs(i)*Xa(i)*M(i);
end
title('All modes attenuated with actuator and sensor arm');

%% Plot total transfer function
f2 = figure(4);
bodeplot(P, 'k', p);
title('Modal using all considered modes');
    
%% Only maxi modes with biggest norm
maxi = 10;

for i = 2:n
    normM(i) = norm(Zs(i)*Xa(i)*M(i),2);
end

[Y I] = sort(normM, 'descend');

PT = tf(0,1);           % initiate truncated model tranfer
for i = 1:maxi-1
    PT = PT+Zs(I(i))*Xa(I(i))*M(I(i));
end

% plot truncated model
f5 = figure(5); hold on
bodeplot(P,'k',p);
bodeplot(PT,'r',p);
legend( sprintf('%i modes',n), sprintf('%i modes',maxi));

% plot next mode
f6 = figure(6); hold on
bodeplot(P,'k',p);
bodeplot(PT,'r',p);
bodeplot(Zs(I(maxi))*Xa(I(maxi))*M(I(maxi)),'b',p);
legend(sprintf('%i modes',n), sprintf('%i modes',maxi), sprintf('Next mode: %i', I(maxi)));
    
%% Truncated model: maxi Modes with biggest norm and frequency < 5000 Hz
maxi = 4;
fmax = 5000;            % maximum frequency to consider in truncated model

PT = tf(0,1);           % initiate truncated model tranfer
k = 1;
for i = 1:n
    if f(I(i)) > fmax;  % add all modes until fmax
        continue;
    end
    PT = PT+Zs(I(i))*Xa(I(i))*M(I(i));
    k = k+1;
    if k > maxi;        % stop at maxi modes
        break;
    end
end

% plot truncated model
f7 = figure(7); hold on;
bodeplot(P,p);
bodeplot(PT,'r',p);
legend(sprintf('%i modes',n), sprintf('%i biggest modes with f < %i [Hz]',maxi,fmax));
%% calculate different norms
for i = 1:n
    normM(i) = norm(M(i),2);
    normAM(i) = norm(Xa(i)*M(i),2);
    normSAM(i) = norm(Zs(i)*Xa(i)*M(i),2);
end


transfer1= M(I(1));
transfer2= M(I(2));
transfer3= M(I(3));
transfer4= M(I(4));
                                                                               
