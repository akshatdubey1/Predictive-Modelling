%% Stage Transfer from Force to Measurement

% Transfer from Force point A to Displacement point B
A = [0  0  0  1  0 -F];
B = [1  0 -o  0  0  0];
%A = 3;
%B = 6;
for i=1:n
    mode(i) = tf([(A*V(:,i))*(B*V(:,i))],[MM(i) CC(i) KK(i)]);
end

%% Plot transfer

% Get default plotoptions and modify
p = bodeoptions;
p.Grid = 'on';
p.FreqUnits = 'Hz';
p.MagUnits = 'abs';
p.MagScale = 'log';

% Plot separate modes, then including summed, then only summed
figure(1);
bodeplot( mode(1), 'r', mode(2), 'r', mode(4), 'r', mode(6), 'r', logspace(1,4,1000)*2*pi, p);

figure(2);
bodeplot( mode(1), 'r', mode(2), 'r', mode(4), 'r', mode(6), 'r', ...
    mode(1)+mode(2)+mode(3)+mode(4)+mode(5)+mode(6), 'k', logspace(1,4,1000)*2*pi, p);

figure(3);
hold on
bode( mode(1)+mode(2)+mode(3)+mode(4)+mode(5)+mode(6), 'k', logspace(1,4,1000)*2*pi, p);
