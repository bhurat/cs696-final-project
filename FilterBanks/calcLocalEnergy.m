function Energies = calcLocalEnergy(ewtc,winSize)
[h,w,d] = size(ewtc);
Energies = zeros(h,w,d);
for k = 1:d
    coef = ewtc(:,:,k);
    coef = wextend('2D','symw',coef,winSize);
    for i = 1:h
        for j = 1:w
            for p = -winSize:winSize
                for q = -winSize:winSize
                    Energies(i,j,k) = Energies(i,j,k) + abs(coef(winSize+i+p,winSize+j+q)).^2;
                end
            end
        end
    end
end
end