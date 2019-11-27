function ewtc = applyFilterBank(f,mfb)

% We filter the signal to extract each subband
ff=fft2(f);
ewtc = zeros([size(f) (length(mfb)-1)*length(mfb{2})]);
for s = 2:length(mfb)
    for t = 1:length(mfb{2})
    ewtc(:,:,(s-1)*t+t) = real(ifft2(conj(mfb{s}{t}).*ff));
    end
end
end