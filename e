warning: LF will be replaced by CRLF in EWT/2D/Curvelet/EWT2D_Curvelet_FilterBank.m.
The file will have its original line endings in your working directory
[1mdiff --git a/CNN/trainingTest.m b/CNN/trainingTest.m[m
[1mindex 55d74af..02f75f3 100644[m
[1m--- a/CNN/trainingTest.m[m
[1m+++ b/CNN/trainingTest.m[m
[36m@@ -5,7 +5,7 @@[m [maddpath('../FilterBanks/','../PolarLab/');[m
 nfold = '000';[m
 imageDir = fullfile(['../Outex_SS_00000/' nfold]);[m
 imSet = imageSet(imageDir,'recursive');[m
[31m-imNum = 5;[m
[32m+[m[32mimNum = 1;[m
 [m
 %Create random permutation of number of images, keep first imNum images[m
 rng(3929);[m
[36m@@ -33,7 +33,8 @@[m [mfor i = 1:trainNum[m
     ewtc = applyFilterBank(read(imSet(1),arrTrainID(i)),mfb);[m
     [m
     %apply local energy computation[m
[31m-    featIm = localEnergyComputation(ewtc);[m
[32m+[m[32m    %featIm = localEnergyComputation(ewtc);[m
[32m+[m[32m    featIm = ewtc;[m
     trainingFeatures(128*128*(i-1) + 1:128*128*i,:) = reshape(featIm,[128*128 featureSize]);[m
     load(['../groundtruths/GT' int2str(arrTrainID(i)) '.mat']);[m
     trainingLabels(128*128*(i-1)+1 : 128*128*i) = reshape(L,[128*128 1]);[m
[36m@@ -43,9 +44,9 @@[m [mfprintf('\n Done storing training features \n')[m
 [m
 %% Train classifier[m
 %knn (Probably needs extra preprocessing)[m
[31m-%classifier = fitcknn(trainingFeatures, trainingLabels);[m
[32m+[m[32mclassifier = fitcknn(trainingFeatures, trainingLabels);[m
 %multiclass svm[m
[31m-classifier = fitcecoc(trainingFeatures, uint8(trainingLabels));[m
[32m+[m[32m%classifier = fitcecoc(trainingFeatures, uint8(trainingLabels));[m
 %boosting[m
 %classifier = fitensemble(X,Y,'Method','AdaBoostM2','NumLearningCycles',5,'Learners','Tree');[m
 [m
[1mdiff --git a/EWT/2D/Curvelet/EWT2D_Curvelet_FilterBank.m b/EWT/2D/Curvelet/EWT2D_Curvelet_FilterBank.m[m
[1mindex cc15058..df09f0f 100644[m
[1m--- a/EWT/2D/Curvelet/EWT2D_Curvelet_FilterBank.m[m
[1m+++ b/EWT/2D/Curvelet/EWT2D_Curvelet_FilterBank.m[m
[36m@@ -58,7 +58,7 @@[m [mif option==1[m
            DTheta=r;[m
         end[m
     end[m
[31m-[m
[32m+[m[41m    [m
     r=(Bt(1)+pi-Bt(end))/2;[m
     if r<DTheta [m
         DTheta=r; [m
[1mdiff --git a/ExampleDriver.m b/ExampleDriver.m[m
[1mindex 6720510..072d335 100644[m
[1m--- a/ExampleDriver.m[m
[1m+++ b/ExampleDriver.m[m
[36m@@ -6,24 +6,18 @@[m [mclear;[m
 verbose = 0;[m
 [m
 %Set all of the MANY parameters for EWT package. [m
[31m-params.log = 0; params.preproc = 'none'; params.reg = 'none'; [m
[31m-params.lengthFilter = 7; params.sigmaFilter = 1;[m
[31m-params.completion = 0;[m
[31m-params.detect = 'scalespace'; params.typeDetect = 'otsu'; [m
[31m-params.curvpreproc = 'none'; params.curvreg = 'none'; params.option = 1;[m
[31m-params.curvdegree = 1; params.curvlengthFilter = 1;[m
[31m-params.curvsigmaFilter = 1; params.curvmethod = 'scalespace';[m
[31m-params.globtrend = 'none';[m
[31m-[m
[32m+[m[32mparams = EWTDefaultParams();[m
 %Set folder number and folder name for problem[m
[31m-nfold = '000';[m
[31m-folname = strcat('Outex_SS_00000/',nfold,'/');[m
 [m
 %call buildSupervisedTextureFilterBank to build filter bank from texture[m
 %library of given problem[m
 %[m
 %NOTE: Should shorten this function's name[m
[31m-[Bw, Bt,M] = buildSupervisedTextureFilterBank(nfold,params);[m
[32m+[m
[32m+[m[32mnfold = '002';[m
[32m+[m[32m[mfb,Bw,Bt] = buildSupervisedTextureFilterBank(nfold, params,[.2 .07]);[m
[32m+[m
[32m+[m[32mfolname = strcat('Outex_SS_00000/',nfold,'/');[m
 [m
 %Load in problem[m
 fProb = imread(strcat(folname,'problem.ras')); [m
[36m@@ -38,6 +32,6 @@[m [mShow_Curvelets_boundaries(fProb,Bw,Bt,1);[m
 [m
 %Apply filter bank for test problem (temp) and show them[m
 ewtc = applyFilterBank(fProb,Bw,Bt,params);[m
[31m-if verbose == 1[m
[31m-    Show_EWT2D_Curvelet(ewtc);[m
[31m-end[m
[32m+[m[32m% if verbose == 1[m
[32m+[m[32m%     Show_EWT2D_Curvelet(ewtc);[m
[32m+[m[32m% end[m
[1mdiff --git a/Outex_SS_00000/GT2TrainingData.m b/Outex_SS_00000/GT2TrainingData.m[m
[1mindex 49936f4..125152e 100644[m
[1m--- a/Outex_SS_00000/GT2TrainingData.m[m
[1m+++ b/Outex_SS_00000/GT2TrainingData.m[m
[36m@@ -1,26 +1,38 @@[m
 %to be run in Outex_SS_00000[m
[31m-i = 0;[m
[31m-for i= 0:9[m
[32m+[m[32m%i = 0;[m
[32m+[m[32m for i= 0:9[m
     folname = ['00' int2str(i) '/'];[m
[32m+[m[41m    [m
[32m+[m[32m    for k = 1:5[m
[32m+[m[32m        begx = ceil(rand*128); begy = ceil(rand*128);[m
[32m+[m[32m        temp = imread([folname 'train_0' int2str(k) '.ras']);[m
[32m+[m[32m        textur{k} = temp(begy:begy+127,begx:begx+127);[m
[32m+[m[32m    end[m
     for j = 1:1000[m
[31m-        L = load(['../groundtruths/GT' int2str(j) '.mat']);[m
[32m+[m[32m        load(['../groundtruths/GT' int2str(j) '.mat']);[m
         im = zeros(size(L));[m
         for k = 1:5[m
[31m-            textur = imread([folname 'train_0' int2str(k) '.ras']);[m
[31m-            im(L==k) = texture(L==1);[m
[32m+[m[32m            im(L==k) = textur{k}(L==k);[m
         end[m
[32m+[m[32m        im = im./255;[m
         imwrite(im,[folname 'Data' int2str(j) '.ras'])[m
     end[m
[31m-end[m
[31m-% for i = 10:99[m
[31m-%     folname = ['0' int2str(i)];[m
[31m-%     for j = 1:1000[m
[31m-%         L = load(['groundtruths/GT' int2str(k) '.mat']);[m
[31m-%         im = zeros(size(L));[m
[31m-%         for k = 1:5[m
[31m-%             textur = imread([folname 'train_0' int2str(k) '.ras']);[m
[31m-%             im(L==k) = texture(L==1);[m
[31m-%         end[m
[31m-%     end[m
[31m-%     imwrite(im,['Data' int2str(j) '.ras'])[m
[31m-% end[m
\ No newline at end of file[m
[32m+[m[32m    i[m
[32m+[m[32m end[m
[32m+[m[32mfor i = 10:99[m
[32m+[m[32m    folname = ['0' int2str(i) '/'];[m
[32m+[m[32m    for k = 1:5[m
[32m+[m[32m        begx = ceil(rand*128); begy = ceil(rand*128);[m
[32m+[m[32m        temp = imread([folname 'train_0' int2str(k) '.ras']);[m
[32m+[m[32m        textur{k} = temp(begy:begy+127,begx:begx+127);[m
[32m+[m[32m    end[m
[32m+[m[32m    for j = 1:1000[m
[32m+[m[32m        load(['../groundtruths/GT' int2str(k) '.mat']);[m
[32m+[m[32m        im = zeros(size(L));[m
[32m+[m[32m        for k = 1:5[m
[32m+[m[32m            im(L==k) = textur{k}(L==k);[m
[32m+[m[32m        end[m
[32m+[m[32m    imwrite(im,[folname 'Data' int2str(j) '.ras'])[m[41m    [m
[32m+[m[32m    end[m
[32m+[m[32m    i[m
[32m+[m[32mend[m
\ No newline at end of file[m
[1mdiff --git a/applyFilterBank.m b/applyFilterBank.m[m
[1mdeleted file mode 100644[m
[1mindex 42f4128..0000000[m
[1m--- a/applyFilterBank.m[m
[1m+++ /dev/null[m
[36m@@ -1,17 +0,0 @@[m
[31m-function ewtc = applyFilterBank(f,Bw,Bt,params)[m
[31m-[H,W] = size(f);[m
[31m-mfb = EWT2D_Curvelet_FilterBank(Bw,Bt,W,H,params.option);[m
[31m-[m
[31m-% We filter the signal to extract each subband[m
[31m-ff=fft2(f);[m
[31m-[m
[31m-ewtc=cell(length(mfb),1);[m
[31m-% We extract the low frequencies first[m
[31m-ewtc{1}=real(ifft2(conj(mfb{1}).*ff));[m
[31m-for s=2:length(mfb)[m
[31m-    ewtc{s}=cell(length(mfb{s}),1);[m
[31m-    for t=1:length(mfb{s})[m
[31m-        ewtc{s}{t}=real(ifft2(conj(mfb{s}{t}).*ff));[m
[31m-    end[m
[31m-end[m
[31m-end[m
\ No newline at end of file[m
[1mdiff --git a/buildSupervisedTextureFilterBank.m b/buildSupervisedTextureFilterBank.m[m
[1mdeleted file mode 100644[m
[1mindex 8d9cbdd..0000000[m
[1m--- a/buildSupervisedTextureFilterBank.m[m
[1m+++ /dev/null[m
[36m@@ -1,65 +0,0 @@[m
[31m-function [Bw, Bt,maxima] = buildSupervisedTextureFilterBank(nfold,params)[m
[31m-%Get folder name to navigate[m
[31m-folname = strcat('Outex_SS_00000/',nfold,'/');[m
[31m-[m
[31m-%initialize output arrays[m
[31m-Bw = [];[m
[31m-Bt = [];[m
[31m-maxima = [];[m
[31m-[m
[31m-%For each texture, we're going to load image, take its pseudopolar fft, and[m
[31m-%get the radial and angular bou