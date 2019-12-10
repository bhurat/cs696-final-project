function features = getFeatures(img,method,params)
    switch lower(method)
        case 'ewt'
            img = im2double(img);
            [~, img] = TVG_CartoonTexture(img);
            ewtc = applyFilterBank(img,params.mfb);  
            %apply local energy computation
            featIm = calcLocalEnergy(ewtc,params.postproc);
            features = reshape(featIm,[size(featIm,1)*size(featIm,2) size(featIm,3)]);
        case 'gabor'
            img = im2double(img);
            [~, img] = TVG_CartoonTexture(img);
            featIm = buildGaborFeatures(img);
            features = reshape(featIm,[h*w size(featIm,3)]);
        case 'glcs'
            img = im2double(img);
            %[~,img] = TVG_CartoonTexture(img);
            featIm = graycomatrix(img);
            features = reshape(featIm,[h*w size(featIm,3)]);
    end
end