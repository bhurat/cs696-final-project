%Function getSpectrumMaxima
%Inputs: 
%   - Bw: Combined radial boundaries
%   - Bt: Combined angular boundaries
%   - rad_thresh: radial threshold
%   - ang_thresh: angular threshold
%
%Outputs:
%   - Bw: new radial boundaries
%   - Bt: new angular boundaries
%
% Removes boundaries that are too close (as per threshold)
%
%Author - Basile Hurat SDSU Applied Mathematics

function [Bw,Bt] = removeBoundsThreshold(Bw,Bt,rad_thresh,ang_thresh);
%Look at each 2 subsequent radial boundaries. If their difference is less
%than or equal to our threshold, remove the larger one
Bw = Bw(Bw>rad_thresh);
for i = 1:length(Bw)-1
    if Bw(i+1)-Bw(i) <= rad_thresh
        avg = (Bw(i+1) + Bw(i))/2;
        Bw(i+1) = Bw(i);
        Bw(i) = -100;
    end
end
%Remove boundaries we removed
Bw = unique(Bw(Bw~= -100));

%Process repeated for angular boundaries

for i = 1:length(Bt)-1
    if Bt(i+1) - Bt(i) <= ang_thresh
        avg = (Bt(i+1) + Bt(i))/2;
        Bt(i+1) = Bt(i);
        Bt(i) = -100;
    end
end
Bt = unique(Bt(Bt~=-100));
end