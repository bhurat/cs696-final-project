function ewtc = applyFilterBank(f,Bw,Bt,params)
[H,W] = size(f);
mfb = EWT2D_Curvelet_FilterBank(Bw,Bt,W,H,params.option);

% We filter the signal to extract each subband
ff=fft2(f);

ewtc=cell(length(mfb),1);
% We extract the low frequencies first
ewtc{1}=real(ifft2(conj(mfb{1}).*ff));
for s=2:length(mfb)
    ewtc{s}=cell(length(mfb{s}),1);
    for t=1:length(mfb{s})
        ewtc{s}{t}=real(ifft2(conj(mfb{s}{t}).*ff));
    end
end
end