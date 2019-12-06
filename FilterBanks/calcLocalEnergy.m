function Energies = calcLocalEnergy(ewtc,winSize)
[h,w,d] = size(ewtc);
Energies = zeros(h,w,d);
for k = 1:d
    for i = 1:h
        for j = 1:w
            for p = -winSize:winSize
                for q = -winSize:winSize
                    if i+p < 1 || i + p > h || j+q < 1 || j+q > w
                        continue
                    end
                    Energies(i,j,k) = Energies(i,j,k) + abs(ewtc(i+p,j+q,k)).^2;
                end
            end
        end
    end
end
end