clc;
clear all;

% EA Engine installation path
installPath = 'C:\Program Files\Bruel and Kjaer\EA Engine';
% EA Engine executable filename (including full path)
assemblyName = 'C:\Program Files\Bruel and Kjaer\EA Engine\EA_Engine.exe';

% Add the EA Engine .NET assembly (please note that it cannot be removed from the current MATLAB session until exiting)
EA_Engine = NET.addAssembly(assemblyName);
% Import the assembly namespace
import EA_Engine.*;

% Declare and instanciate a new Engine object (the installation path is mandatory)
engine = Engine(installPath);

% Listeners for a .NET object (here the engine object)
% Events are:
% - Feedback: returns information during a task execution
% - CalibrationResultsUpdated: returns the updated results during the measurement (concerns only input or output callibration, the other tests don't raise this event)
% - TestResultsAvailable: returns the test results once the acquisition and processing are finished (concerns all the tasks)
lh_Feedback = addlistener(engine, 'Feedback', @Feedback);
lh_CalibrationResultsUpdated = addlistener(engine,'CalibrationResultsUpdated',@CalibrationResultsUpdated);
lh_CalibrationResultsAvailable = addlistener(engine, 'TestResultsAvailable', @CalibrationResultsAvailable);

% Set the output calibration settings
calibrationSettings = engine.SetOutputCalibrationSettings(1000, 0.025, 10, 8192);

% Define the arguments for the first output channel calibration using the first calibrated input as reference (see user's manual for details)
arguments = sprintf('%s %s %s', 'Calibrate_Output_Channel', '1', '1');
% Execute the task
engine.Execute(arguments);

% Delete the listeners once the task is finished
delete (lh_Feedback);
delete (lh_CalibrationResultsUpdated);
delete (lh_CalibrationResultsAvailable);