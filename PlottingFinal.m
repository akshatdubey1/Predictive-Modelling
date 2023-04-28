%% Frequency response for Q2
%% Plotting
%Set the bode plot options
opts = bodeoptions("cstprefs");
opts.FreqUnits = ('Hz');
opts.MagUnits = ('abs');
opts.Grid = ('on');
opts.MagScale = ('log');



Linearizer_Q2 = load("finalfinal.mat");

Q2_linsys11 = Linearizer_Q2.LinearAnalysisToolProject.Results(1).Data.Value(1,1);
Q2_linsys12 = Linearizer_Q2.LinearAnalysisToolProject.Results(1).Data.Value(1,2);
Q2_linsys21 = Linearizer_Q2.LinearAnalysisToolProject.Results(1).Data.Value(2,1);
Q2_linsys22 = Linearizer_Q2.LinearAnalysisToolProject.Results(1).Data.Value(2,2);

figure;
bode(Q2_linsys11,Q2_linsys12,Q2_linsys21,Q2_linsys22,opts)
legend("yL to S1", "yR to S1", "yL to S2","yR to S1")

figure;

margin(Q2_linsys11)

figure;

margin(Q2_linsys12)
figure;

margin(Q2_linsys21)
figure;

margin(Q2_linsys22 ...
    )
