function dispMetricAccuracy(groundtruths,predicted,verbose)
    if nargin < 3
        verbose = 1;
    end
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
        if (verbose == 1)
            disp([measures{ii} repmat(' ',1,6-length(measures{ii})) ': ' num2str(result)])
        else
            disp([num2str(result)]);
        end
        sumAvg = sumAvg + result;
	end
    sumAvg = sumAvg/length(measures);
    if verbose == 1
        disp(['avg' '   : ' num2str(sumAvg)]);
    else
        disp(num2str(sumAvg));
    end
end
