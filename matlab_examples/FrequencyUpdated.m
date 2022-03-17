function FrequencyUpdated(src, event)
    frequency = double(event.CurrentFrequency);  
    step = int32(event.CurrentStep);
    lineLength = fprintf('Frequency (Hz): %.2f - Step %d/%d', frequency, step, int32(event.TotalSteps));
    pause(0.001);
    if (step < int32(event.TotalSteps))
        fprintf(repmat('\b', 1 ,lineLength));
    else
        fprintf('\n');
    end     
end