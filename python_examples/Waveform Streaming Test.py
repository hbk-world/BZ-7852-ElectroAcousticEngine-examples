import pythoncom
import clr

pythoncom.CoInitialize()

# EA Engine installation path
installPath = "C:\\Program Files\\Bruel and Kjaer\\EA Engine"
# Add the EA Engine .NET assembly (EA Engine executable filename - including full path)
clr.AddReference("C:\\Program Files\\Bruel and Kjaer\\EA Engine\\EA_Engine.exe")
# Import the assembly namespace
from EA_Engine import *

# Import the functions used by handlers
from Feedback import feedback
from TimeUpdated import timeupdated
from AverageUpdated import averageupdated

# Declare and instanciate a new Engine object (the installation path is mandatory)
engine = Engine(installPath)

# Add handlers for a .NET object (here the engine object)
# Events are:
# - Feedback: returns information during a task execution
# - TimeUpdated: returns the time elapsed during data acquisiton
# - AverageUpdated: return the average updated during processing (FFT)
engine.Feedback += feedback
engine.TimeUpdated += timeupdated
engine.AverageUpdated += averageupdated

# Define first output settings
generator = engine.SetOutputChannel(1, "4227-A", True, "None", 1, "V/V", 1, GeneratorSignalType.WaveformStreaming)
# Define waveform streaming settings for this output
waveformSettings = engine.SetOutputChannelWaveformStreamingSettings(1, "C:\\Users\\Stephane\\Documents\\EA Engine\\thunder struck_96kHz.wav", 1, 0.1)

# Execute the task
engine.Execute('Waveform_Streaming_Test')

# Remove handlers
engine.Feedback -= feedback
engine.TimeUpdated -= timeupdated
engine.AverageUpdated -= averageupdated
