for i = 0:9
nfold = ['00' int2str(i)];
params = EWTDefaultParams;
mfb = buildSupervisedTextureFilterBank(nfold,params,[.2 .07]);
save(['Outex_SS_00000/' nfold '/filter.mat'],'mfb');
fprintf('iter: %i\n',i);
end

for i = 10:99
nfold = ['0' int2str(i)];
mfb = buildSupervisedTextureFilterBank(nfold,params,[.2 .07]);
save(['Outex_SS_00000/' nfold '/filter.mat'],'mfb');
fprintf('iter: %i\n',i);
end

