function TestResultsAvailable(src,event)

    if (isempty(event.PhaseAssignedSpectrumAmplitude) == 0)
        subplot(1, 1, 1);
   
        plot(event.FrequencyAxis, event.PhaseAssignedSpectrumAmplitude);            
        xlim([100 10000]);
         
        title('Phase Assigned Spectrum');
    else
        if (isempty(event.FrfAmplitude) == 0)
            subplot(2, 1, 1);

            if (isempty(event.AutoSpectrum) == 0)         
                plot(event.FrequencyAxis, event.AutoSpectrum); 
                xlim([100 10000]);
            end

            title('Autospectrum');    

            subplot(2, 1, 2);

            plot(event.FrequencyAxis, event.FrfAmplitude); 
            xlim([100 10000]);

            title('FRF');    
        else
            subplot(1, 1, 1);

            if (isempty(event.AutoSpectrum) == 0)         
                plot(event.FrequencyAxis, event.AutoSpectrum); 
                xlim([100 10000]);
            end

            title('Autospectrum');    
        end
    end
             
    drawnow;
end