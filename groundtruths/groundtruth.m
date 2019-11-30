i = 1;
while (i <= 20)
    image = rand(256,256);
    I = imgaussfilt(image,20);
    threshold = median(image(:));
    BW = imbinarize(I,threshold);
    BW = imfill(BW,'holes');
    BW2 = -(BW-1);
    [L2,m] = bwlabel(BW2);
    [L,n] = bwlabel(BW);
    if (n + m == 5)
        L(L==0) = L2(L==0)+ max(L(:));
        if checkRegSizes(L,900)
            figure,imshow(L,[]);
            save(['GT' int2str(i) '.mat'],'L');
        else
            continue;
        end
    else
        continue;
    end
    i = i + 1;
end

function flag = checkRegSizes(L,n)
    nregions = max(L(:));
    flag = 1;
    for i = 1:nregions
        if sum(L==i,'all') < n
            flag = 0;
        end
    end
end
