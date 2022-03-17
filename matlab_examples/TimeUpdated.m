function TimeUpdated(src, event)
    time = double(event.CurrentTime);  
    lineLength = fprintf('%s%.2f', string(event.CurrentMessage), time);
    pause(0.01);
    if (time < double(event.Duration))
        fprintf(repmat('\b', 1 ,lineLength));
    else
        fprintf('\n');
    end    
end