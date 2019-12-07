addpath('../FilterBanks/','../PolarLab/','../Cartoon_Texture_Decomposition/');

%also add fold and all subfolders of EWT to path

%choose folder number, load image directory, and choose number of images
nfold = '000';
imageDir = fullfile(['../Outex_SS_00000/' nfold]);
imSet = imageSet(imageDir,'recursive');
imNum = 1000;
postproc = 5;
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
    img = im2double(read(imSet(1),arrTrainID(i)));
    [~, img] = TVG_CartoonTexture(img);
    ewtc = applyFilterBank(img,mfb);  
    %apply local energy computation
    featIm = calcLocalEnergy(ewtc,postproc);
    trainingFeatures(h*w*(i-1) + 1:h*w*i,:) = reshape(featIm,[h*w size(ewtc,3)]);
    
    load(['../groundtruths/GT' int2str(arrTrainID(i)) '.mat']);
    trainingLabels(h*w*(i-1)+1 : h*w*i) = reshape(L,[h*w 1]);
end

fprintf('\n Done storing training features \n')

%% Train classifier
%knn (Probably needs extra preprocessing)
%classifier = fitcknn(trainingFeatures, trainingLabels);
%multiclass svm
%classifier = fitcecoc(trainingFeatures, uint8(trainingLabels));
%naive bayesian classifier
classifier =  fitcnb(trainingFeatures,trainingLabels);

fprintf('\n Done training classifier \n')

%% Load test and get its features
test = im2double(read(imSet(1),1001));
[~, test] = TVG_CartoonTexture(test);
ewtc = applyFilterBank(test,Bw,Bt);
featIm = calcLocalEnergy(ewtc,postproc);
testFeatures = reshape(featIm,[512*512 size(ewtc,3)]);

%% Run test through classifier, reshape to image, and show image
predictedLabels = predict(classifier, testFeatures);
predictedPixels = reshape(predictedLabels,[512 512]);
imshow(predictedPixels,[]);
fprintf('\n Done fitting test problem \n')

%Get and show resulting accuracy
GroundTruths = uint8(255*im2double(imread('../Outex_SS_00000/ground_truth.ras')));
unique(GroundTruths)
figure();
confChart = confusionchart(reshape(GroundTruths,[512*512 1]),uint8(predictedLabels));