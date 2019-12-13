addpath('../FilterBanks/','../PolarLab/','../Utilities');

%also add fold and all subfolders of EWT to path

%choose folder number, load image directory, and choose number of images
nfold = '000';
imageDir = fullfile(['../Outex_SS_00000/' nfold]);
imSet = imageSet(imageDir,'recursive');
imSize = 256;
imNum = 10;
postproc = 9;
%Create random permutation of number of images, keep first imNum images
if imSize == 128
    imMax = 1000;
    imfold = ['../Outex_SS_00000/' nfold '/Data'];
    GTfold = '../groundtruths/GT';
elseif imSize == 256
    imMax = 250;
    imfold = ['../Outex_SS_00000/' nfold '/sz256Data'];
    GTfold = '../groundtruths/sz256/GT';
end

rng(3929);
tmparr = randperm(imMax); tmparr = tmparr(1:imNum);

%Set training array (and optionally testing array)

trainID = tmparr; %(1:round(3*imNum/4));
% arrTestID = tmparr(length(arrTrainID)+1:imNum);
trainNum = length(trainID);
%Get image sizes
[h,w] = size(imread([imfold '1.ras']));

%Load filter bounds and create filter bank for training
load(['../Outex_SS_00000/' nfold '/filter.mat']);
mfb = EWT2D_Curvelet_FilterBank(Bw,Bt,h,w,1);

% Initialize feature arrays and labels
featureSize = length(Bw)*(length(Bt));
trainingFeatures = zeros(h*w*trainNum,featureSize);
trainingLabels = zeros(h*w*trainNum,1);

%Collect feature and label data
for i = 1:trainNum
    img = im2double(imread([imfold int2str(trainID(i)) '.ras']));
    [~, img] = TVG_CartoonTexture(img);
    ewtc = applyFilterBank(img,mfb);  
    %apply local energy computation
    featIm = calcLocalEnergy(ewtc,postproc);
    trainingFeatures(h*w*(i-1) + 1:h*w*i,:) = reshape(featIm,[h*w size(ewtc,3)]);
    
    load([GTfold int2str(trainID(i)) '.mat']);
    trainingLabels(h*w*(i-1)+1 : h*w*i) = reshape(L,[h*w 1]);
end

fprintf('\nDone storing training features \n')

%% Train classifier

%multiclass svm
classifier = fitcecoc(trainingFeatures, trainingLabels);

fprintf('Done training classifier \n')

%% Load test and get its features
tic
test = im2double(read(imSet(1),1001));
[~, test] = TVG_CartoonTexture(test);
ewtc = applyFilterBank(test,Bw,Bt);
featIm = calcLocalEnergy(ewtc,postproc);
testFeatures = reshape(featIm,[512*512 size(ewtc,3)]);

%% Run test through classifier, reshape to image, and show image
predictedLabels = predict(classifier, testFeatures);
toc
predictedPixels = reshape(predictedLabels,[512 512]);
imshow(predictedPixels,[]);
fprintf('Done fitting test problem \n')

%Get and show resulting accuracy
GroundTruths = uint8(255*im2double(imread('../Outex_SS_00000/ground_truth.ras')));
figure();
confChart = confusionchart(reshape(GroundTruths,[512*512 1]),uint8(predictedLabels));
dispMetricAccuracy(GroundTruths,predictedPixels);