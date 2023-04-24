function [Error,error_time,error_data] = ErrorEval(Filename)

Error_output=load(Filename);
error_time = squeeze(Error_output.ans.Time); %Eliminate extra dimension of array
error_time = round(error_time,4); %Round the number to help find function
error_time_350 = find(error_time == 0.4500); %Find the index of 0.3500
error_time_350 = error_time_350(1); %First 350ms index
error_data = squeeze(Error_output.ans.Data); %Eliminate extra dimension of array
error_data_350 = error_data(error_time_350); %Error corresponding to time 0.3500
Error = error_data_350;