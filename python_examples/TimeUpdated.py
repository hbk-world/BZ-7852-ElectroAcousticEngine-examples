def timeupdated(source, args):
    if args.CurrentTime < args.Duration:
        print('\r{0}: {1:.2f}'.format(args.CurrentMessage, args.CurrentTime), end='')
    else:
        print('')