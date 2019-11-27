function [Bw,Bt] = removeBoundsLocMax(Bw,Bt,maxima)

%take and separate the max radial values and angular values for sorting
%Make sure they're in order (Maybe not needed?) and remove repeat values
maxR = unique(sort(maxima(:,1)));
maxTheta = unique(sort(maxima(:,2)));


%Go through window from 2 subsequent radial boundaries - If a one or more 
%maxima are within window, keep. If no minima are, replace both boundaries
%by their midpoint.

%NOTE: Since we're guaranteeing whole numbers always (maxima are indices
%and we round when we take midpoint), we guarantee that we can just look at
%range (Bw(i):Bw(i+1)) and not do some true false. Maybe later we can
%change this
for i = 1:length(Bw)-1
    flag = 1; 
    for j = 1:length(maxR)
        if ismember(maxR(j),Bw(i):Bw(i+1))
            flag = 0;
            break
        end
    end
    if flag == 1
        Bw(i+1) = round((Bw(i)+Bw(i+1))/2);
        Bw(i) = -100;
    end
end

%Same process for angular boundaries
for i = 1:length(Bt)-1
    flag = 1;
    for j = 1:length(maxTheta)
        if ismember(maxTheta(j),Bt(i):Bt(i+1))
            flag = 0;
            break
        end
    end
    if flag == 1
        Bt(i+1) = round((Bt(i)+Bt(i+1))/2);
        Bt(i) = -100;
    end
end

%Here we remove image bounds and the boundaries that we removed earlier
Bw = Bw(2:end-1); Bw = sort(Bw(Bw~=-100));
Bt = Bt(2:end-1); Bt = sort(Bt(Bt~=-100));
end