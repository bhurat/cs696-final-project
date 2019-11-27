filename = '../Outex_SS_00000/';
for i = 0:9
    nfold = ['00' int2str(i) '/'];
    for j = 1:1000
        im = imload([filename nfold 'Data' int2str(j) '.ras']);
        load([filename nfold 'filter.mat']);
        ewtc = applyFilterBank(im,mfb);
        save([filename nfold 'Features' int2str(j) '.mat'],'ewtc');
    end
end
for i = 10:99
nfold = ['00' int2str(i) '/'];
    for j = 1:1000
        im = imload([filenamen fold 'Data' int2str(j) '.ras']);
        load([filename nfold 'filter.mat']);
        ewtc = applyFilterBank(im,mfb);
        save([filename nfold 'Features' int2str(j) '.mat'],'ewtc');
    end
end