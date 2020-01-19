clear all;

% simfile_name = {'no_error1', 'assertion_error', 'no_error2'};

simfile_name = ...
{'C:\Users\Tsubasa\Documents\MATLAB\no_error2.slx',
'C:\Users\Tsubasa\Documents\MATLAB\assertion_error.slx',
'C:\Users\Tsubasa\Documents\MATLAB\no_error1.slx'}

% simOut = sim(simfile_name{2}, 'CaptureErrors', 'on');
% simOut = sim(simfile_name{2});
% stop_event = simOut.getSimulationMetadata.ExecutionInfo.StopEvent
% 
for i=1:1:3
    simOut = sim(simfile_name{i}, 'CaptureErrors', 'on');
    stop_event = simOut.getSimulationMetadata.ExecutionInfo.StopEvent;
    if stop_event == 'DiagnosticError'
        disp(strcat('error occur on'))
        disp(strcat(simfile_name{i}, '.slx'))
    end
end