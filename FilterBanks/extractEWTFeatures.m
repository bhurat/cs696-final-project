function ewtFeatures = extractEWTFeatures(nfold, imNum)
    if nargin < 2
        imNum = 1000;
    end
    filename = '../Outex_SS_00000/';
    load([filename nfold '/filter.mat']);
    ewtFeatures = cell(imNum,1);
    
    for j = 1:imNum
        im = imread([filename nfold '/Data' int2str(j) '.ras']);
        ewtFeatures{j} = applyFilterBank(im,mfb);
         %save([filename nfold 'Features' int2str(j) '.mat'],'ewtc');
    end


    % end
    % for i = 10:99
    % nfold = ['00' int2str(i) '/'];
    %     for j = 1:1000
    %         im = imload([filenamen fold 'Data' int2str(j) '.ras']);
    %         load([filename nfold 'filter.mat']);
    %         ewtc = applyFilterBank(im,mfb);
    %         save([filename nfold 'Features' int2str(j) '.mat'],'ewtc');
    %     end
    %    i
    % end
end