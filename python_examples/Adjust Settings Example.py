import sys

import pythoncom
import clr

pythoncom.CoInitialize()

# EA Engine installation path
installPath = "C:\\Program Files\\Bruel and Kjaer\\EA Engine"
# Add the EA Engine .NET assembly (EA Engine executable filename - including full path)
clr.AddReference("C:\\Program Files\\Bruel and Kjaer\\EA Engine\\EA_Engine.exe")
# Import the assembly namespace
from EA_Engine import *

# Declare and instanciate a new Engine object (the installation path is mandatory)
engine = Engine(installPath)

# Get version of the EA Engine installed
print(engine.GetVersion())

# Get EA Engine settings
engineSettings = engine.GetEngineSettings()
if engine.ErrorMessage != "":
    print(engine.ErrorMessage)
    sys.exit()
else:
    print("EA Engine settings:")
    print("Data Folder: ", engineSettings.DataFolder)
    print("Settling Time (s): ", engineSettings.SettlingTime)
    print("Integrate/Differentiate: ", engineSettings.IntegrateDifferentiate)
    print("Calibration Threshold: ", engineSettings.CalibrationThreshold)
    print("\n")

# Set EA Engine settings (for example, set settling time to 1 s and ask to differenciate once)
engineSettings = engine.SetEngineSettings(engineSettings.DataFolder, 1, 1, engineSettings.CalibrationThreshold)
if engine.ErrorMessage != "":
    print(engine.ErrorMessage)
    sys.exit()

# Detect ASIO devices
devices = engine.DetectDevices()
if engine.ErrorMessage != "":
    print(engine.ErrorMessage)
    sys.exit()

# List detected devices
print("Detected devices:")
for device in devices:
    print("Index: ", device.Index)
    print("Name: ", device.Name)
    print("ASIO Driver Name: ", device.ASIODriverName)
    print("Selected: ", device.Selected)
    print("\n")

# Select the first device (index starts at 1) and keep existing Input Channels.xml and Output Channels.xml files
device = engine.SelectDevice(1, False)
if engine.ErrorMessage != "":
    print(engine.ErrorMessage)
    sys.exit()

# Get detected devices
devices = engine.GetDetectedDevices()
if engine.ErrorMessage != "":
    print(engine.ErrorMessage)
    sys.exit()

# List (again) detected devices - the selected device will have now its Selected property set to true
print("Detected devices once one has been selected:")
for device in devices:
    print("Index: ", device.Index)
    print("Name: ", device.Name)
    print("ASIO Driver Name: ", device.ASIODriverName)
    print("Selected: ", device.Selected)
    print("\n")

# Get selected device capabilities
deviceCapabilities = engine.GetSelectedDeviceCapabilities()
if engine.ErrorMessage != "":
    print(engine.ErrorMessage)
    sys.exit()

# List the selected device capabilities
print("Selected device capabilities:")
print("Sample Rate (Hz): {0:.0f}".format(deviceCapabilities.SampleRate))
print("Buffer Size: ", deviceCapabilities.BufferSize)
print("Input Latency (samples): ", deviceCapabilities.InputLatency)
print("Input Latency (ms): {0:.2f}".format(deviceCapabilities.InputLatencyTime))
print("Output Latency (samples): ", deviceCapabilities.OutputLatency)
print("Output Latency (ms): {0:.2f}".format(deviceCapabilities.OutputLatencyTime))
print("\n")

# Get input channels
inputChannels = engine.GetInputChannels(False)
if engine.ErrorMessage != "":
    print(engine.ErrorMessage)
    sys.exit()

# Set first input channel (first way)
inputChannels[0] = engine.SetInputChannel(1, "4944-A", True, "4227-A", 0.84, "mV/Pa", 2e-5)
if engine.ErrorMessage != "":
    print(engine.ErrorMessage)
    sys.exit()

# Set first input channel (second way)
inputChannels[1].Name = "Input Channel 2"
inputChannels[1].IsActive = False
inputChannels[1].ReferenceChannelName = "None"
inputChannels[1].Sensitivity = 1000
inputChannels[1].SensitivityUnit = "mV/V"
inputChannels[1].dBRef = 1
engine.SetInputChannels(inputChannels)
if engine.ErrorMessage != "":
    print(engine.ErrorMessage)
    sys.exit()

# Get output channels
outputChannels = engine.GetOutputChannels(False)
if engine.ErrorMessage != "":
    print(engine.ErrorMessage)
    sys.exit()

# Set first output channel (first way)
outputChannels[0] = engine.SetOutputChannel(1, "4227-A", True, "None", 1, "V/V", 1, GeneratorSignalType.White)
if engine.ErrorMessage != "":
    print(engine.ErrorMessage)
    sys.exit()

# Set first output channel (second way)
outputChannels[1].Name = "Generator 2"
outputChannels[1].IsActive = False
outputChannels[1].ReferenceChannelName = "None"
outputChannels[1].Sensitivity = 500
outputChannels[1].SensitivityUnit = "mV/V"
outputChannels[1].dBRef = 1
outputChannels[1].SignalType = GeneratorSignalType.Sine
engine.SetOutputChannels(outputChannels)

# Set first output Random settings (used when its signal type is set to White or Pink)
randomSettings = engine.SetOutputChannelRandomSettings(1, 0.025, True, 80, 12000, 0, 5)
if engine.ErrorMessage != "":
    print(engine.ErrorMessage)
    sys.exit()