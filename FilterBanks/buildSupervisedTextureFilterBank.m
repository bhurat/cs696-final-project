function [mfb,Bw,Bt] = buildSupervisedTextureFilterBank(nfold,params,thresh)
if nargin < 3
thresh = [.2 .07];
end

%Get folder name to navigate
folname = ['Outex_SS_00000\' nfold '\'];
for i = 1:5
%initialize output arrays
Bw = [];
Bt = [];
maxima = [];

%For each texture, we're going to load image, take its pseudopolar fft, and
%get the radial and angular boundaries as per EWT2D_Curvelet function w/
%option 1.
%
%Also, we'll calculate the maxima on the windows created by detected radii
%and angles on the image
for i = 1:5
    f = im2double(imread([folname 'Train_0' num2str(i) '.ras']));
    [h,w,d] = size(f);
    if d > 1
        f = mean(f,3);
    end
    % PSEUDO-FFT
    PseudoFFT = PPFFT(f);
    meanppfft=fftshift(sum(abs(PseudoFFT),2));
    [h,w] = size(PseudoFFT);
    % Detect the radial boundaries
    boundaries1 = EWT_Boundaries_Detect(meanppfft(1:round(length(meanppfft)/2)),params);
    
    
    %Store radial boundaries
    Bw = [Bw;boundaries1]; 
    
    % Compute the mean spectrum with respect to the magnitude frequency to find
    % the angles
    meanppfft=sum(abs(PseudoFFT),1);

    % Detect angular boundaries
    boundaries2 = EWT_Angles_Detect(meanppfft',params);
    
    %Store angular boundaries
    Bt = [Bt; boundaries2];
    
    % Call getSpectrumMaxima to detect maxima locations
    maxima = [maxima; getSpectrumMaxima(PseudoFFT,boundaries1,boundaries2)];
    
end

%Sort and remove repeat values
Bw = sort(unique(Bw)); Bt = sort(unique(Bt));

% Call removeBoundsLocMax to remove based on maxima detected
[Bw, Bt] = removeBoundsLocMax([1;Bw;round(w/2)],[1;Bt;h],maxima);

% Normalize
Bw = Bw*pi/round(length(meanppfft)/2);
Bt = (Bt-1)*pi/length(meanppfft)-3*pi/4;

% Call removeBoundsThreshold to remove based on threshold 
%(paper says dr = .2, dtheta = .07)
% 
maxima = Bw;
%Currently implemented w/out finding midpoints since it made no sense and
%also didn't work in practice
[Bw,Bt] = removeBoundsThreshold(Bw,Bt,thresh(1),thresh(2));
mfb = EWT2D_Curvelet_FilterBank(Bw,Bt,w,h,params.option);
end