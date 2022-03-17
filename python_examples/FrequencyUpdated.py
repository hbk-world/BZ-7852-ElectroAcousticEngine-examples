def frequencyupdated(source, args):
    if args.CurrentStep < args.TotalSteps:
        print('\rFrequency (Hz): {0:.2f} - Step {1} / {2}'.format(args.CurrentFrequency, args.CurrentStep,
                                                                  args.TotalSteps), end='')
    else:
        print('\rFrequency (Hz): {0:.2f} - Step {1} / {2}'.format(args.CurrentFrequency, args.TotalSteps,
                                                                  args.TotalSteps), end='')
        print('')