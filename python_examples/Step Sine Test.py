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
from FrequencyUpdated import frequencyupdated

# Declare and instanciate a new Engine object (the installation path is mandatory)
engine = Engine(installPath)

# Add handlers for a .NET object (here the engine object)
# Events are:
# - Feedback: returns information during a task execution
# - TimeUpdated: returns the time elapsed during data acquisiton
# - FrequencyUpdated: returns the frequency udpate during processing (harmonic estimator)
engine.Feedback += feedback
engine.TimeUpdated += timeupdated
engine.FrequencyUpdated += frequencyupdated

# Define first output settings
generator = engine.SetOutputChannel(1, "4227-A", True, "None", 1, "V/V", 1, GeneratorSignalType.Step);
# Define step settings for this output
stepSettings = engine.SetOutputChannelStepSineSettings(1, 0.02, 12000, 80, StepSineResolutionType.R80, 12, 0.01, ScanningModeType.Linear, 1, 5, 100);

# Execute the task
engine.Execute('Step_Sine_Test')

# Remove handlers
engine.Feedback -= feedback
engine.TimeUpdated -= timeupdated
engine.FrequencyUpdated -= frequencyupdated
