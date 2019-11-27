%to be run in Outex_SS_00000
i = 0;
for i= 0:9
    folname = ['00' int2str(i) '/'];
    for j = 1:1000
        L = load(['../groundtruths/GT' int2str(j) '.mat']);
        im = zeros(size(L));
        for k = 1:5
            textur = imread([folname 'train_0' int2str(k) '.ras']);
            im(L==k) = texture(L==1);
        end
        imwrite(im,[folname 'Data' int2str(j) '.ras'])
    end
end
% for i = 10:99
%     folname = ['0' int2str(i)];
%     for j = 1:1000
%         L = load(['groundtruths/GT' int2str(k) '.mat']);
%         im = zeros(size(L));
%         for k = 1:5
%             textur = imread([folname 'train_0' int2str(k) '.ras']);
%             im(L==k) = texture(L==1);
%         end
%     end
%     imwrite(im,['Data' int2str(j) '.ras'])
% end