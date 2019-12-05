% Function: applyFilterBank
%Inputs: (f, mfb) or (f,Bw,Bt)
%   - f: image to apply filter bank to
%   - mfb: precalculated filter bank (useful for speed when repeating on
%   images of same size)
%   - Bw: Radial boundaries (if you don't have prebuilt filter bank)
%    - Bt: Angular boundaries
%
%Outputs:
%   - ewtc: Empirical wavelet coefficients-tensor of image size w/ # of 
%   channels equal to # of filters minus approximation coef

%Applies filter bank specified to an image and returns its coefficients to
%for use in EWT feature histograms
% Author: Basile Hurat  SDSU Applied Mathematics
function ewtc = applyFilterBank(f,Bw,Bt)
if nargin<3
    mfb = Bw;
else
    [h,w] = size(f);
    mfb = EWT2D_Curvelet_FilterBank(Bw,Bt,h,w,1);
end
% We filter the signal to extract each subband
ff=fft2(f);
ewtc = zeros([size(f) (length(mfb)-1)*length(mfb{2})]);
for s = 2:length(mfb)
    for t = 1:length(mfb{2})
    ewtc(:,:,(s-2)*length(mfb{2})+t) = real(ifft2(conj(mfb{s}{t}).*ff));
    end
end

end