function [Bw, Bt] = buildSupervisedTextureFilterBank(nfold,params)
folname = strcat('Outex_SS_00000/',nfold,'/');
Bw = [];
Bt = [];


for i = 1:5
    filename = strcat(folname,'train_0',num2str(i),'.ras');
    f = im2double(imread(filename))/255;
    [h, w, d] = size(f);
    if d > 1
        f = f(:,:,1);
    end
    %% PSEUDO-FFT
    PseudoFFT = PPFFT(f);
    meanppfft=fftshift(sum(abs(PseudoFFT),2));
    
    %% GET LOCAL MAXIMA
    %TO DO
    
    %% Detect the radial boundaries
    boundaries = EWT_Boundaries_Detect(meanppfft(1:round(length(meanppfft)/2)),1,params);
    Bw = [Bw;boundaries*pi/round(length(meanppfft)/2)];

    % Compute the mean spectrum with respect to the magnitude frequency to find
    % the angles
    meanppfft=sum(abs(PseudoFFT),1);

    %% DETECT THE ANGULAR BOUNDARIES
    boundaries = EWT_Angles_Detect(meanppfft',params);
    Bt = [Bt; (boundaries-1)*pi/length(meanppfft)-3*pi/4];
end
% 
% %REMOVE BASED ON LOCAL MAXIMA
% % TO DO
% %REMOVE BASED ON THRESHOLD (paper says dr = .2, dtheta = .07)
rad_thresh = .2; ang_thresh = .07;
for i = 1:length(Bw)-1
    if Bw(i+1)-Bw(i) < rad_thresh
        avg = (Bw(i+1)+Bw(i))/2;
        Bw(i) = -1;
        Bw(i+1) = avg;
    end
end
Bw = unique(Bw(Bw~= -1));

for i = 1:length(Bt)-1
    if Bt(i+1) - Bt(i) < ang_thresh
        avg = (Bt(i+1) + Bt(i))/2;
        Bt(i) = -1;
        Bt(i+1) = avg;
    end
end
Bt = unique(Bt(Bt~=-1));
end