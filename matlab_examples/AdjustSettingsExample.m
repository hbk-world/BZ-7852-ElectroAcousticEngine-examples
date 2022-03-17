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

% Get version of the EA Engine installed
disp(engine.GetVersion());

% Get EA Engine settings
engineSettings = engine.GetEngineSettings();
if (engine.ErrorMessage ~= "")
    disp(engine.ErrorMessage);
    return;
end

% List EA Engine settings
fprintf('EA Engine settings:\n');
fprintf('Data Folder : %s\n', string(engineSettings.DataFolder));
fprintf('Settling Time (s): %d\n', engineSettings.SettlingTime);
fprintf('Integrate/Differentiate: %d\n', engineSettings.IntegrateDifferentiate);
fprintf('Calibration Threshold: %d\n', engineSettings.CalibrationThreshold);
fprintf('\n');

% Set EA Engine settings (for example, set settling time to 0 s
engineSettings = engine.SetEngineSettings(engineSettings.DataFolder, 0, 0, engineSettings.CalibrationThreshold);
if (engine.ErrorMessage ~= "")
    disp(engine.ErrorMessage);
    return;
end

% Detect ASIO devices
devices = engine.DetectDevices();
if (engine.ErrorMessage ~= "")
    disp(engine.ErrorMessage);
    return;
end

% List detected devices
fprintf('Detected devices:\n');
for i = 1:length(devices)
   fprintf('Index: %d\n', devices(i).Index);
   fprintf('Name: %s\n', string(devices(i).Name));
   fprintf('ASIO Driver Name: %s\n', string(devices(i).ASIODriverName));
   fprintf('Selected: %s\n', mat2str(devices(i).Selected));
   fprintf('\n');
end

% Select the first device (index starts at 1) and keep existing Input Channels.xml and Output Channels.xml files
device = engine.SelectDevice(1, false);
if (engine.ErrorMessage ~= "")
    disp(engine.ErrorMessage);
    return;
end

% Get detected devices
devices = engine.GetDetectedDevices();
if (engine.ErrorMessage ~= "")
    disp(engine.ErrorMessage);
    return;
end

% List (again) detected devices - the selected device will have now its Selected property set to true
fprintf('Detected devices once one has been selected:\n');
for i = 1:length(devices)
   fprintf('Index: %d\n', devices(i).Index);
   fprintf('Name: %s\n', string(devices(i).Name));
   fprintf('ASIO Driver Name: %s\n', string(devices(i).ASIODriverName));
   fprintf('Selected: %s\n', mat2str(devices(i).Selected));
   fprintf('\n');
end

% Get selected device capabilities
deviceCapabilities = engine.GetSelectedDeviceCapabilities();
if (engine.ErrorMessage ~= "")
    disp(engine.ErrorMessage);
    return;
end

% List the selected device capabilities
fprintf('Selected device capabilities:\n');
fprintf('Sample Rate (Hz): %d\n', deviceCapabilities.SampleRate);
fprintf('Buffer Size: %d\n', deviceCapabilities.BufferSize);
fprintf('Input Latency (samples): %d\n', deviceCapabilities.InputLatency);
fprintf('Input Latency (ms): %.2f\n', deviceCapabilities.InputLatencyTime);
fprintf('Output Latency (samples): %d\n', deviceCapabilities.OutputLatency);
fprintf('Output Latency (ms): %.2f\n', deviceCapabilities.OutputLatencyTime);
fprintf('\n');

% Get input channels
inputChannels = engine.GetInputChannels(false);
if (engine.ErrorMessage ~= "")
    disp(engine.ErrorMessage);
    return;
end

% Set first input channel (first way)
inputChannels(1) = engine.SetInputChannel(1, '4944-A', true, '4227-A', 0.84, 'mV/Pa', 2e-5); 
if (engine.ErrorMessage ~= "")
    disp(engine.ErrorMessage);
    return;
end

% Set first input channel (second way)
inputChannels(2).Name = 'Input Channel 2';
inputChannels(2).IsActive = false;
inputChannels(2).ReferenceChannelName = 'None';
inputChannels(2).Sensitivity = 1000;
inputChannels(2).SensitivityUnit = 'mV/V';
inputChannels(2).dBRef = 1;
engine.SetInputChannels(inputChannels);
if (engine.ErrorMessage ~= "")
    disp(engine.ErrorMessage);
    return;
end

% Get output channels
outputChannels = engine.GetOutputChannels(false);
if (engine.ErrorMessage ~= "")
    disp(engine.ErrorMessage);
    return;
end

% Set first output channel (first way)
outputChannels(1) = engine.SetOutputChannel(1, '4227-A', true, 'None', 1, 'V/V', 1, GeneratorSignalType.White); 
if (engine.ErrorMessage ~= "")
    disp(engine.ErrorMessage);
    return;
end

% Set first output channel (second way)
outputChannels(2).Name = 'Generator 2';
outputChannels(2).IsActive = false;
outputChannels(2).ReferenceChannelName = 'None';
outputChannels(2).Sensitivity = 500;
outputChannels(2).SensitivityUnit = 'mV/V';
outputChannels(2).dBRef = 1;
outputChannels(2).SignalType = GeneratorSignalType.Sine;
engine.SetOutputChannels(outputChannels);
if (engine.ErrorMessage ~= "")
    disp(engine.ErrorMessage);
    return;
end

% Set first output Random settings (used when its signal type is set to White or Pink)
randomSettings = engine.SetOutputChannelRandomSettings(1, 0.025, true, 80, 12000, 0, 5);
if (engine.ErrorMessage ~= "")
    disp(engine.ErrorMessage);
    return;
end
