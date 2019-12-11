%to be run in Outex_SS_00000
%i = 0;
%  for i= 0:9
%     folname = ['00' int2str(i) '/'];
%     
%     for k = 1:5
%         begx = ceil(rand*128); begy = ceil(rand*128);
%         temp = imread([folname 'train_0' int2str(k) '.ras']);
%         textur{k} = temp;%(begy:begy+127,begx:begx+127);
%     end
%     for j = 1:250
%         load(['../groundtruths/sz256/GT' int2str(j) '.mat']);
%         im = zeros(size(L));
%         for k = 1:5
%             im(L==k) = textur{k}(L==k);
%         end
%         im = im./255;
%         imwrite(im,[folname 'sz256Data' int2str(j) '.ras'])
%     end
%     i
%  end
for i = 70:99
    folname = ['0' int2str(i) '/'];
    for k = 1:5
        begx = ceil(rand*128); begy = ceil(rand*128);
        temp = imread([folname 'train_0' int2str(k) '.ras']);
        textur{k} = temp(begy:begy+127,begx:begx+127);
    end
    for j = 1:1000
        load(['../groundtruths/GT' int2str(j) '.mat']);
        im = zeros(size(L));
        for k = 1:5
            im(L==k) = textur{k}(L==k);
        end
        im = im./255;
    imwrite(im,[folname 'Data' int2str(j) '.ras'])    
    end
    i
end