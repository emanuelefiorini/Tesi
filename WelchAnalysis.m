function [F,PXX] = WelchAnalysis(Data,HDR)
% calculating sampling frequency
freq = HDR.samplerate(1);
%welch Analysis
[pxx,f]= pwelch(Data',[],[],[],freq); %welch Analysis
%cutting original band (fs/72) to band frequency alpha and beta waves
%(13Hz-40Hz)
bandIndexes = (f>13)&(f<40); 
F = f(bandIndexes,1);
    for  k=1:size(pxx,2)
    PXX(:,k) = pxx((bandIndexes),k);
    end
    
end