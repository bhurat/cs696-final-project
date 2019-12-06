Bw = [];
Bt = [];
numIms = 100; %dims 256x256
numFilters = length(Bw)*length(Bt);
training_lab = zeros([numims*256*256 1]); %labels
training_vals = zeros([numims*256*256 numFilters]);

for n = 1:numims
    lab = groundtruth; %getGT
    im = image_n; %get im
    ewtc = applyFilterBank(im,Bw,Bt,params); %Apply filter
    ewtc2 = reshape(ewtc,size(ewtc,1)*size(ewtc,2),size(ewtc,3));
    for i = 1:length(im(:))
        training_lab((n-1)*length(im(:)) + i) = lab(i); %label
        for j = 1:numFilters
            training_vals((n-1)*length(im(:)) + i,j) = ewtc2(i,j);
        end
    end
end
%knn
fitcknn(training_vals,training_lab,'NumNeighbors',5,'distance','cityblock');

%multiclass svm
%ClassificationECOC(training_vals,training_lab,)


%TO APPLY PROBLEM
imP = imread('problem.ras');
ewtc = filter(imP); %filter problem 
imPmask = imP; 
for i = 1:length(imP(:))
imPmask(i) = training_lab(knnRes(i));
end



