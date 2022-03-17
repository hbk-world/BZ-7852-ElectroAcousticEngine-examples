function Feedback(src, event)
    fprintf('%s - %s', string(event.MessageType), string(event.Message));
    fprintf('\n');
end