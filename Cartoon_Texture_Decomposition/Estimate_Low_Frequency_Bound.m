function lowfreq = Estimate_Low_Frequency_Bound(f)

param.log=0;
param.detect='scalespace';
param.completion=0;
param.globtrend = 'none';
param.reg = 'none';
param.typeDetect='otsu';

% Pseudo Polar FFT of f
PseudoFFT=PPFFT(f);

% Compute the mean spectrum with respect to the angle
meanppfft=fftshift(sum(abs(PseudoFFT),2));
%plot(meanppfft);

% Detect the boundaries
boundaries = EWT_Boundaries_Detect(meanppfft(1:round(length(meanppfft)/2)),param);
%lowfreq = boundaries(1)*pi/round(length(meanppfft)/2);
lowfreq = boundaries(1);
