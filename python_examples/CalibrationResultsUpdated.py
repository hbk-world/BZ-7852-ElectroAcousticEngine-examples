

def calibrationresultsupdated(source, args):
    if args.CurrentAverageNumber < args.TotalAverages:
        print('\rCurrent time elapsed: {0:.2f} s  -  Current average: {1} / {2}'.format(args.CurrentTimeElapsed, args.CurrentAverageNumber, args.TotalAverages), end='')
    else:
        print('')





