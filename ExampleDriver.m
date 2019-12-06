close all;
clear;

%Change verbose to 1 to see results of filtering 
%WARNING: (makes a lot of figures)
verbose = 0;

%Set all of the MANY parameters for EWT package. 
params = EWTDefaultParams();
%Set folder number and folder name for problem

%call buildSupervisedTextureFilterBank to build filter bank from texture
%library of given problem
%
%NOTE: Should shorten this function's name

nfold = '002';
[mfb,Bw,Bt] = buildSupervisedTextureFilterBank(nfold, params,[.2 .07]);

folname = strcat('Outex_SS_00000/',nfold,'/');

%Load in problem
fProb = imread(strcat(folname,'problem.ras')); 
fProb = im2double(fProb(:,:,1));
figure()

%Show its fourier transform
imshow(log(abs(fftshift(fft2(fProb)))),[]);

%Show boundary result
Show_Curvelets_boundaries(fProb,Bw,Bt,1);

%Apply filter bank for test problem (temp) and show them
ewtc = applyFilterBank(fProb,Bw,Bt,params);
% if verbose == 1
%     Show_EWT2D_Curvelet(ewtc);
% end
