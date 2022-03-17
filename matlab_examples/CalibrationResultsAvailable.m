function CalibrationResultsAvailable(src,event)
    subplot(1, 1, 1);
    
    if (isempty(event.AutoSpectrum) == 0)         
        plot(event.FrequencyAxis, event.AutoSpectrum); 
        xlim([500 1500]);
    end
      
    title('Autospectrum');    
         
    drawnow;
end