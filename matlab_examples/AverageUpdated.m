function AverageUpdated(src, event)   
    average = int32(event.CurrentAverage);  
    lineLength = fprintf('Average: %d/%d', average, int32(event.TotalAverages));
    pause(0.001);
    if (average < int32(event.TotalAverages))
        fprintf(repmat('\b', 1, lineLength));
    else
        fprintf('\n');
    end           
end