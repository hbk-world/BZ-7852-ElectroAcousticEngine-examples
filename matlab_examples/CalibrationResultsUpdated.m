function CalibrationResultsUpdated(src, event)
    subplot(2, 1, 1);   
    
    if (isempty(event.TimeAxis) == 0)
        x = double(event.TimeAxis);
        plot(x, double(event.TimeBlock));  
        xlim([x(1) x(length(x))]);
    end
               
    title('Time'); 
    legend(sprintf('Time elapsed (s): %.2f', event.CurrentTimeElapsed));
    
    subplot(2, 1, 2);
    
    if (isempty(event.FrequencyAxis) == 0)        
        plot(double(event.FrequencyAxis), double(event.ResponseAutoSpectrum));    
        xlim([500 1500])  ;
    end
   
    title('Averaged Autospectrum (RMS)');    
    legend(sprintf('Average: %d/%d', event.CurrentAverageNumber,event.TotalAverages));
     
    drawnow;
end