function B2 = checkDist(B,T)
flag = ones(size(B(1:end-1)));
flag = 1;
while flag
    flag = 0;
    for i = 1:length(B)-1
    if B(i) < 0
        continue
    end
%     if B(i+1) - B(i) < T
        B(i) = (B(i) + B(i+1))/2;
        B(i+1) = -1;
        flag = 1;
    end
    B = B(B>=0);
end
B2 = B(B>0);
end