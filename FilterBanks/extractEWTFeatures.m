%Function extractEWTFeatures
%Inputs: 
%   - nfold: 3 character string like '000' or '076'
%   - imNum: (int) number of images you want to pull features for (default at
%   max of 1000)
%
%Outputs:
%   - ewtFeatures: cell object of size imNum
%
%Function that loads in filter for a folder and applies it to images in
%that folder and returns it. 
%histogram of image #i, pixel (j,k) is extracted w/ ewtFeatures{i}(j,k,:)


%Author - Basile Hurat SDSU Applied Mathematics
%ADDENDUM: SOME LINES COMMENTED OUT FOR PREVIOUS USE

function ewtFeatures = extractEWTFeatures(nfold, imNum)
    if nargin < 2   %Default params
        imNum = 1000;
    end
    filename = '../Outex_SS_00000/';    %Dataset folder
    load([filename nfold '/filter.mat']); %Loads in filter
    ewtFeatures = cell(imNum,1); %initialize output cell
    
    %loop through images, reads them, applies filter, and stores it
    for j = 1:imNum
        im = imread([filename nfold '/Data' int2str(j) '.ras']);
        %if this is first iteration, create filter bank based on image size
        if j == 1
            [h,w] = size(im);
            mfb = EWT2D_Curvelet_FilterBank(Bw,Bt,h,w,1);
        end
        ewtFeatures{j} = applyFilterBank(im,mfb);
         %save([filename nfold 'Features' int2str(j) '.mat'],'ewtc'); %(IGNORE)
    end

    %%%IGNORE
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