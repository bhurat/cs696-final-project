%Checks if a a label has big enough regions 
function flag = checkRegSizes(L,n)
    nregions = max(L(:));
    flag = 1;
    for i = 1:nregions
        if sum(L==i,'all') < n
            flag = 0;
        end
    end
end