%Function getSpectrumMaxima
%Inputs: 
%   - PseudoFFT: psuedo-polar fourier transform of an image
%   - boundariesScale: Scale boundaries detected by EWT
%   - boundariesAngular: Angular boundaries detected by EWT
%
%Outputs:
%   - maxima: Coordinates of maxima in each filter 
%
%Function that, given a segmentation from the EWT, finds the maxima in each
%region. Use for creating combined filter bank
%
%Author - Basile Hurat SDSU Applied Mathematics
function [maxima] = getSpectrumMaxima(PseudoFFT,boundariesScale,boundariesAng)
    %Initialize output array
    maxima = [];
    %Take magnitude of psuedopolar fourier transform so we're not working
    %in complex
    absppfft = abs(PseudoFFT);
    
    [h,w] = size(absppfft);
    
    %Create radii/angle arrays w/ bounds included
    tempRad = sort([1; boundariesScale;round(h/2)]); %Symmetric so only up to half
    tempTheta = sort([1; boundariesAng; w]);  
    
    %Go through bounds, construct window for filter, find maximum
    for j = 1:length(tempRad)-1
        for  k = 1:length(tempTheta)-1
            window = absppfft(tempRad(j):tempRad(j+1),tempTheta(k):tempTheta(k+1));
            [maxR,maxTheta] = find(absppfft == max(window(:)));
            
            %Here we guarantee that we keep the one in our window
            keep = ismember(maxR,tempRad(j):tempRad(j+1));
            maxR = maxR(keep); maxTheta = maxTheta(keep);
            keep = ismember(maxTheta,tempTheta(k):tempTheta(k+1));
            maxR = maxR(keep); maxTheta = maxTheta(keep);
            
            %Store in maxima
            maxima = [maxima; maxR maxTheta];
        end
    end
end