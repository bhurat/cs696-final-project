params.log = 0; params.preproc = 'none'; params.reg = 'none'; 
params.completion = 0;
params.detect = 'scalespace'; params.typeDetect = 'otsu'; 
params.curvpreproc = 'none'; params.curvreg = 'none'; params.option = 1;
params.curvdegree = 10; params.curvlengthFilter = 10;
params.curvsigmaFilter = 10; params.curvmethod = 'scalespace';
params.globtrend = 'none';

nfold = '001';
folname = strcat('Outex_SS_00000/',nfold,'/');

[Bw, Bt] = buildSupervisedTextureFilterBank(nfold,params);


fProb = imread(strcat(folname,'problem.ras')); 
fProb = im2double(fProb(:,:,1));
figure()
imshow(log(abs(fftshift(fft2(fProb)))),[]);

Show_Curvelets_boundaries(fProb,Bw,Bt,1);
