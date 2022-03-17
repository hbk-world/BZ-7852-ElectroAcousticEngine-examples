import matplotlib.pyplot as plt


def calibrationresultsavailable(source, args):
    if args.AutoSpectrum.Length != 0:
        f = []
        auto = []
        for i in range(0, args.FrequencyAxis.Length):
            if (args.FrequencyAxis[i] >= 500) and (args.FrequencyAxis[i] <= 1500):
                f.append(args.FrequencyAxis[i])
                auto.append(args.AutoSpectrum[i, 0])

        plt.subplots(1, 1)
        plt.plot(f, auto)
        plt.xlabel('Frequency [Hz]')
        plt.ylabel('Amplitude [Pa]')
        plt.title('Autospectrum')
        plt.show()
