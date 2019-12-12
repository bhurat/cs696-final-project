function outMag = buildGaborFeatures(img)
    wavelength = [2 4 6 8 10];
    orientation = [0 45 90 135];
    g = gabor(wavelength,orientation);
    outMag = imgaborfilt(img,g);
end