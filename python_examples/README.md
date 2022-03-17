Requirements for EA Engine programming with Python:

The IDE used to write these examplesis PyCharm Community Edition 2021 (but other IDEs are supported)
The interpreter is Python 3.8 (please don't use upper versions because one of the mandatory package is not yet supported - pythonnet)

Python packages:
- PyQt5 (for the example code with GUI)
- pythonnet (for .NET assemblies support - mandatory for the EA Engine)
- pypiwin32 (for STA thread support - mandatory for NAudio, one of the dependency of the EA Engine)
- pyqtgraph (for graph displays - more performant than matplotlib)
- numpy (numerical library, if necessary)
- scipy (scientific library, if necessary)

For GUI development, Qt Designer is advised.