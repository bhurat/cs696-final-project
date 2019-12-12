function dispMetricAccuracy(groundtruths,predicted)
measures = {
            'nvoi',... % Normalized variation of information
            'ssc' ,... % Segmentation covering (two directions)
            'sdhd',... % Directional Hamming distance (two directions)
            'bgm' ,... % Bipartite graph matching
            'vd'  ,... % Van Dongen
            'bce' ... % Bidirectional consistency error
            };
        sumAvg = 0;
        for ii=1:length(measures)
    result = eval_segm(predicted, groundtruths, measures{ii});
    disp([measures{ii} repmat(' ',1,6-length(measures{ii})) ': ' num2str(result)])
        sumAvg = sumAvg + result;
        end
        sumAvg = sumAvg/length(measures);
    disp(['avg' '   : ' num2str(sumAvg)]);
end
