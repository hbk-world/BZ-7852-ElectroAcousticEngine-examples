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
% - TimeUpdated: returns the time elapsed during data acquisiton
% - AverageUpdated: return the average updated during processing (FFT)
% - FrequencyUpdated: returns the frequency udpate during processing (harmonic estimator)
% - TestResultsAvailable: returns the test results once the acquisition and processing are finished
lh_Feedback = addlistener(engine, 'Feedback', @Feedback);
lh_TimeUpdated = addlistener(engine, 'TimeUpdated', @TimeUpdated);
lh_AverageUpdated = addlistener(engine, 'AverageUpdated', @AverageUpdated);
lh_FrequencyUpdated = addlistener(engine, 'FrequencyUpdated', @FrequencyUpdated);
lh_TestResultsAvailable = addlistener(engine, 'TestResultsAvailable', @TestResultsAvailable);

% Define the arguments for the first output channel equalization using the first calibrated input as reference (see user's manual for details)
arguments = sprintf('%s %s %s', 'Equalize_Output_Channel', '1', '1');
% Execute the task
engine.Execute(arguments);

% Delete the listeners once the task is finished
delete (lh_Feedback);
delete (lh_TimeUpdated);
delete (lh_AverageUpdated);
delete (lh_FrequencyUpdated);
delete (lh_TestResultsAvailable);
