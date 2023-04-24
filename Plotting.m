%% Plotting
%Set the bode plot options
opts = bodeoptions("cstprefs");
opts.FreqUnits = ('Hz');
opts.MagUnits = ('abs');
opts.Grid = ('on');
opts.MagScale = ('log');


Linearizer_Q2 = load("Q2_sys.mat");
%First data is Q12, second is Q13 system with 75Hz bandwidth
Q2_linsys11 = Linearizer_Q2.LinearAnalysisToolProject.Results(1).Data.Value(1,1);
Q2_linsys12 = Linearizer_Q2.LinearAnalysisToolProject.Results(1).Data.Value(1,2);
Q2_linsys21 = Linearizer_Q2.LinearAnalysisToolProject.Results(1).Data.Value(2,1);
Q2_linsys22 = Linearizer_Q2.LinearAnalysisToolProject.Results(1).Data.Value(2,2);

figure;
bode(Q2_linsys11,Q2_linsys12,Q2_linsys21,Q2_linsys22,sys1,opts)
legend("yL to S1", "yR to S1", "yL to S2","yR to S1")


%Adding controller
[Error,error_time,error_data] = ErrorEval("Error_1_Q3.mat");
Error_1_Q3 = Error;
Error_1_Q3_time=error_time;
Error_1_Q3_data = error_data;

[Error,error_time,error_data] = ErrorEval("Error_2_Q3.mat");
Error_2_Q3 = Error;
Error_2_Q3_time=error_time;
Error_2_Q3_data = error_data;

figure;
plot(Error_1_Q3_time,Error_1_Q3_data); hold on;
plot(Error_2_Q3_time,Error_2_Q3_data);
axis([0 0.7 -15e-6 10e-6])
grid on;
title("Error of the system")
xlabel("Time (s)")
ylabel("Amplitute (m)")

%% 

%Adding delay 0.1ms

[Error,error_time,error_data] = ErrorEval("Error_1_Q4_delay01.mat");
Error_1_Q4_d01 = Error;
Error_1_Q4_d01_time=error_time;
Error_1_Q4_d01_data = error_data;

[Error,error_time,error_data] = ErrorEval("Error_2_Q4_delay01.mat");
Error_2_Q4_d01 = Error;
Error_2_Q4_d01_time=error_time;
Error_2_Q4_d01_data = error_data;

figure;
plot(Error_1_Q4_d01_time,Error_1_Q4_d01_data); hold on;
plot(Error_2_Q4_d01_time,Error_2_Q4_d01_data);
axis([0 0.7 -15e-6 10e-6])
grid on;
title("Error of the system")
xlabel("Time (s)")
ylabel("Amplitute (m)")

%Adding delay 1ms
[Error,error_time,error_data] = ErrorEval("Error_1_Q4_delay1.mat");
Error_1_Q4_d1 = Error;
Error_1_Q4_d1_time=error_time;
Error_1_Q4_d1_data = error_data;

[Error,error_time,error_data] = ErrorEval("Error_2_Q4_delay1.mat");
Error_2_Q4_d1 = Error;
Error_2_Q4_d1_time=error_time;
Error_2_Q4_d1_data = error_data;

figure;
plot(Error_1_Q4_d1_time,Error_1_Q4_d1_data); hold on;
plot(Error_2_Q4_d1_time,Error_2_Q4_d1_data);
axis([0 0.7 -15e-6 10e-6])
grid on;
title("Error of the system")
xlabel("Time (s)")
ylabel("Amplitute (m)")

%% Displacement difference

Disp_2_Q4_d01 = load("Disp_1_Q4_delay01.mat");
Disp_1_Q4_d01 = load("Disp_2_Q4_delay01.mat");
Disp_2_Q4_d1 = load("Disp_1_Q4_delay1.mat");
Disp_1_Q4_d1 = load("Disp_2_Q4_delay1.mat");

figure;
plot(Disp_2_Q4_d01.ans.Time,squeeze(Disp_2_Q4_d01.ans.Data)); hold on;
plot(Disp_1_Q4_d01.ans.Time,squeeze(Disp_1_Q4_d01.ans.Data)); hold on;
plot(Disp_2_Q4_d1.ans.Time,squeeze(Disp_2_Q4_d1.ans.Data)); hold on;
plot(Disp_1_Q4_d1.ans.Time,squeeze(Disp_1_Q4_d1.ans.Data)); 
title("Displacement of the system")
xlabel("Time (s)")
ylabel("Displacement(m)")