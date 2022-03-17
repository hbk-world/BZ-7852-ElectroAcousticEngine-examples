def averageupdated(source, args):
    if args.CurrentAverage < args.TotalAverages:
        print('\rAverage:', args.CurrentAverage, " / ", args.TotalAverages, end='')
    else:
        print('\rAverage:', args.TotalAverages, " / ", args.TotalAverages, end='')
        print('')