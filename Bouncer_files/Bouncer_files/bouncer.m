clear all; close all; clc

% place the sensor at a more sensible location, for example the centre and then
% get data from that simulation again and run this script, know which mode starts
% fucking up the sensor and limit the code accordingly. once that fuckup frequency is 
% known, then design a PID controller for 1/3 bandwidth of that frequency. 

% This file will load the modal data from the COMSOL model. It will then
% plot the tranfer from the actuator location to one of the nodes on the
% sensor block, in Z-direction. You can choose some different nodes on the
% sensor block and combine them to obtain the rotation of the sensor block
% in the YZ-plane.

%% load modal data
% These text files contain the modal data as extracted from the COMSOL
% model. Beware that the first column of these matrices contains to modal
% frequencies (in Hz). To get the displacement in X,Y or Z of the nodes
% on the sensor block, you need to take colum 'node-number+1', with node
% numbers as indicated in the figure.
load ModalMasses_alt.txt
load dispXactuator_alt.txt
load dispXsensor.txt
load dispYsensor.txt
load dispZsensor_alt3.txt

%%
n = size(ModalMasses_alt,1);        % number of modes
f = ModalMasses_alt(:,1);           % eigen frequencies
m = ModalMasses_alt(:,2);           % modal masses
k = m.*(f*2*pi).^2;             % modal stiffnesses
Q = 2e2;                        % quality factor of resonances
c = sqrt(m.*k)/Q;               % damping

% displacement in X of actuator block: you can take the average of the two
% points measured and 
Xa = sum(dispXactuator_alt(:,2:3),2)/2;

% displacement in Z of measurement node. In this case I took node 1, with
% the data provided you can choose different nodes, and by combining them
% you can obtain rotations in the YZ plane.
%Zs = sum(dispZsensor_alt3(:,2:3),2)/2;
%Zs = dispZsensor_alt2(:,2);
%Zs = dispYsensor(:,2);


% calculate effective masses and stiffnesses. These can become negative due
% to the movement of the actuator and sensor point being out of phase.
m_eff = m./(Xa.*Zs);            % effective modal mass
k_eff = k./(Xa.*Zs);            % effective modal stiffness
c_eff = c./(Xa.*Zs);            % effective damping
%% calculate modal masses
for i = 1:n
    if i == 1;
        M(i) = tf(Xa(i).*Zs(i),[m(i) 0 0]);
    else
        M(i) = tf(Xa(i).*Zs(i),[m(i) c(i) k(i)]);
    end
end
%% Plot tranfer
close all
P = tf(0,1);                    % initiate total transfer
f1 = figure();              
for i = 1:n
    b1 = bodeplot(M(i));        % plot modal transfer
    hold on; grid on
    p1 = getoptions(b1);
    p1.FreqUnits = 'Hz';
    setoptions(b1,p1);
    P = P+M(i);                 % add modal transfer to total transfer
end
ht1 = title('All considered modes');

f2 = figure();
    b2 = bodeplot(P); grid on
    p2 = getoptions(b2);
    p2.FreqUnits = 'Hz';
    setoptions(b2,p2);
    ht2 = title('Modal using all considered modes');
    
%% Truncated model
fmax = 2500;            % maximum frequency to consider in truncated model

PT = tf(0,1);           % initiate truncated model tranfer
for i = 1:n
    if f(i) <= fmax;    % add all modes until fmax
    PT = PT+M(i);
    end
end

% plot truncated model
f3 = figure();
    b31 = bodeplot(P); grid on; hold on
    b32 = bodeplot(PT,'r');
    p3 = getoptions(b31);
    p3.FreqUnits = 'Hz';
    setoptions(b31,p3);
    l3 = legend('all modes considered',sprintf('f < %i [Hz]',fmax));
    
%% Only biggest modes (Mass)

[Y I] = sort(abs(m_eff), 'ascend');

msum = sum(abs(m_eff));
mratio = 1e-12*msum;

PPT = M(1);           % initiate truncated model tranfer
mrel = 0.0;
for i = 1:n
    if mrel > mratio 
        break;
    end % add all modes until fmax
    PPT = PPT+M(I(i));
    mrel = mrel + abs(Y(i))/msum
end

% plot truncated model
f4 = figure();
    b31 = bodeplot(P); grid on; hold on
    b32 = bodeplot(PPT,'r');
    p3 = getoptions(b31);
    p3.FreqUnits = 'Hz';
    setoptions(b31,p3);
    l4 = legend('all modes considered', sprintf('total relative mass < %3.2f [-]',mratio));
    
%% Only biggest modes (Stiffness)

[Y I] = sort(abs(k_eff), 'descend');

ksum = sum(abs(k_eff));
kratio = 0.95*ksum;

PPT = M(1);           % initiate truncated model tranfer
krel = 0.0;
for i = 1:n
    if krel > kratio 
        break;
    end % add all modes until fmax
    PPT = PPT+M(I(i));
    krel = krel + abs(Y(i))/ksum
    
end

% plot truncated model
f4 = figure();
    b31 = bodeplot(P); grid on; hold on
    b32 = bodeplot(PPT,'r');
    p3 = getoptions(b31);
    p3.FreqUnits = 'Hz';
    setoptions(b31,p3);
    l4 = legend('all modes considered', sprintf('total relative stiffness < %3.2f [-]',kratio));
    
%% Only modes with biggest norm

for i = 2:n
    %normM(i) = norm(M(i),2);
    normM(i) = norm(M(i),inf);         %norm infinity
end

[Y I] = sort(normM, 'descend');

PPPT = M(1);           % initiate truncated model tranfer
maxi = 10;
for i = 1:maxi-1
    PPPT = PPPT+M(I(i));
end

% plot truncated model
f5 = figure(1);
    b31 = bodeplot(P,'k'); grid on; hold on
    b32 = bodeplot(PPPT,'r');
    p3 = getoptions(b31);
    p3.FreqUnits = 'Hz';
    setoptions(b31,p3);
    l4 = legend('all modes considered', sprintf('%i modes',maxi));
    

% plot next mode
f6 = figure(2);
    b31 = bodeplot(P,'k'); grid on; hold on
    b32 = bodeplot(PPPT,'r');
    b33 = bodeplot(M(I(maxi)));
    p3 = getoptions(b31);
    p3.FreqUnits = 'Hz';
    setoptions(b31,p3);
    l4 = legend('20 modes', sprintf('%i modes',maxi), sprintf('Next mode: %i', I(maxi)));
    
