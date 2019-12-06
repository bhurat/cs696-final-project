addpath('../FilterBanks/','../PolarLab/');
%also add fold and all subfolders of EWT to path

%choose folder number, load image directory, and choose number of images
nfold = '000';
imageDir = fullfile(['../Outex_SS_00000/' nfold]);
imSet = imageSet(imageDir,'recursive');
imNum = 1;

%Create random permutation of number of images, keep first imNum images
rng(3929);
tmparr = randperm(1000); tmparr = tmparr(1:imNum);

%Set training array (and optionally testing array)

arrTrainID = tmparr; %(1:round(3*imNum/4));
% arrTestID = tmparr(length(arrTrainID)+1:imNum);
trainNum = length(arrTrainID);
%Get image sizes
[h,w] = size(read(imSet(1),1));

%Load filter bounds and create filter bank for training
load(['../Outex_SS_00000/' nfold '/filter.mat']);
mfb = EWT2D_Curvelet_FilterBank(Bw,Bt,h,w,1);

% Initialize feature arrays and labels
featureSize = length(Bw)*(length(Bt));
trainingFeatures = zeros(h*w*trainNum,featureSize);
trainingLabels = zeros(h*w*trainNum,1);

%Collect feature and label data
for i = 1:trainNum
    ewtc = applyFilterBank(read(imSet(1),arrTrainID(i)),mfb);
    
    %apply local energy computation
    featIm = calcLocalEnergy(ewtc,3);
    trainingFeatures(128*128*(i-1) + 1:128*128*i,:) = reshape(featIm,[128*128 featureSize]);
    load(['../groundtruths/GT' int2str(arrTrainID(i)) '.mat']);
    trainingLabels(128*128*(i-1)+1 : 128*128*i) = reshape(L,[128*128 1]);
end

fprintf('\n Done storing training features \n')

%% Train classifier
%knn (Probably needs extra preprocessing)
classifier = fitcknn(trainingFeatures, trainingLabels);
%multiclass svm
%classifier = fitcecoc(trainingFeatures, uint8(trainingLabels));
%boosting
%classifier = fitensemble(X,Y,'Method','AdaBoostM2','NumLearningCycles',5,'Learners','Tree');

fprintf('\n Done training classifier \n')

%% Load test and get its features
test = read(imSet(1),1001);
ewtc = applyFilterBank(test,Bw,Bt);
featIm = calcLocalEnergy(ewtc,3);

testFeatures = reshape(featIm,[512*512 featureSize]);

%% Run test through classifier, reshape to image, and show image
predictedLabels = predict(classifier, testFeatures);
predictedPixels = reshape(predictedLabels,[512 512]);
imshow(predictedPixels,[]);
fprintf('\n Done fitting test problem \n')

%Get and show resulting accuracy
GroundTruths = uint8(255*im2double(imread('../Outex_SS_00000/ground_truth.ras')));
unique(GroundTruths)
confusionchart(GroundTruths,predictedLabels);
