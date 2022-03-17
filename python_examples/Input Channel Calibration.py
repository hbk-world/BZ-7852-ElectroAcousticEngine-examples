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
from CalibrationResultsUpdated import calibrationresultsupdated
from CalibrationResultsAvailable import calibrationresultsavailable

# Declare and instanciate a new Engine object (the installation path is mandatory)
engine = Engine(installPath)

# Add handlers for a .NET object (here the engine object)
# Events are:
# - Feedback: returns information during a task execution
# - CalibrationResultsUpdated: returns the updated results during the measurement (concerns only input or output callibration, the other tests don't raise this event)
# - TestResultsAvailable: returns the test results once the acquisition and processing are finished (concerns all the tasks)
engine.Feedback += feedback
engine.CalibrationResultsUpdated += calibrationresultsupdated
engine.TestResultsAvailable += calibrationresultsavailable

# Set the input calibration settings
calibrationSettings = CalibrationSettings()
calibrationSettings.ReferenceFrequency = 1000
calibrationSettings.ReferenceLevel = 94
calibrationSettings.ReferenceUnit = "dB"
calibrationSettings.Duration = 10
calibrationSettings.ResultFileFormatType = ResultFileFormatTypes.CSV
calibrationSettings.CalculateTHD = True
calibrationSettings.HarmonicsTHD = "2,3"
calibrationSettings.AnalysisFFTSettings.BlockSize = 8192

calibrationSettings = engine.SetInputCalibrationSettings(calibrationSettings)

# Execute the task (calibrate input channel 1)
engine.Execute("Calibrate_Input_Channel 1")

# Remove handlers
engine.Feedback -= feedback
engine.CalibrationResultsUpdated -= calibrationresultsupdated
engine.TestResultsAvailable -= calibrationresultsavailable
