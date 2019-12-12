%gabor Hilbert energy for cartoon-texture deomposition. only returns
%texture
function textur = keepTextureofCTD(f)
    eta = .05;
    n = size(f,1);
    x = [0:n/2-1, -n/2:-1]/n;
    [Y,X] = meshgrid(x,x);
    W = 1 ./ (eta + sqrt(X.^2 + Y.^2));
    textur = real(ifft2(fft2(f)./W.^2));
end