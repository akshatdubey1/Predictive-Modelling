%% Stage Mode Animation

scale = 0.1;

M = scale*V(:,mode);
M(3) = 180/pi*M(3);
M(6) = 180/pi*M(6);

N = 72;
t = linspace(0,1,N+1);
C = sin(2*pi*t);
C = C(2:N+1)-C(1:N);

figure('doublebuffer','on')
set(gca,'XLim',[-0.2 0.2],'YLim',[-0.2 0.2])

W = 0.12; % mirror and actuator block width
H = 0.04; % mirror height
Xm = [-W  W  W -W];
Ym = [-H -H  H  H] + b;

XLm = [0   0];
YLm = [-0.05  0.05] + b;

H = 0.02; % actuator height
Xa = [-W  W  W -W];
Ya = [-H -H  H  H];

XLa = [0 0];
YLa = [-0.05 0.15];

rm=patch(Xm,Ym,'y'); % mirror
ra=patch(Xa,Ya,'y'); % actuator

lm=line(XLm,YLm); % spring plate line mirror
la=line(XLa,YLa); % spring plate line actuator

line([0 0], [-0.1 0.2]);

while 1
    for i=1:N
        
        % mirror animation
        
        Xmi = get(rm, 'Xdata');
        Ymi = get(rm, 'Ydata');
        Cmi=[mean(Xmi) mean(Ymi) 0];
        
        rotate(rm, [0 0 1], C(i)*M(3), Cmi)
        
        Xmi = get(rm, 'Xdata');
        set(rm, 'xdata', Xmi+C(i)*M(1));
        Ymi = get(rm, 'Ydata');
        set(rm, 'ydata', Ymi+C(i)*M(2));
     
        % actuator animation
        
        Xai = get(ra, 'Xdata');
        Yai = get(ra, 'Ydata');
        Cai=[mean(Xai) mean(Yai) 0];
        
        rotate(ra, [0 0 1], C(i)*M(6), Cai)
        
        Xai = get(ra, 'Xdata');
        set(ra, 'xdata', Xai+C(i)*M(4));
        Yai = get(ra, 'Ydata');
        set(ra, 'ydata', Yai+C(i)*M(5));
        
        % spring plate animation
        
        rotate(lm, [0 0 1], C(i)*M(3),Cmi)
        Xmi = get(lm, 'Xdata');
        set(lm, 'xdata', Xmi+C(i)*M(1));
        Ymi = get(lm, 'Ydata');
        set(lm, 'ydata', Ymi+C(i)*M(2));

        rotate(la, [0 0 1], C(i)*M(6),Cai)
        Xai = get(la, 'Xdata');
        set(la, 'xdata', Xai+C(i)*M(4));
        Yai = get(la, 'Ydata');
        set(la, 'ydata', Yai+C(i)*M(5));
        
        drawnow
        pause(.01)
        
    end
end
