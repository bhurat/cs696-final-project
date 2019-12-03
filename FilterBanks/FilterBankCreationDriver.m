for i = 0:9
nfold = ['00' int2str(i)];
params = EWTDefaultParams;
[Bw,Bt] = buildSupervisedTextureFilterBank(nfold,params,[.2 .07]);
save(['../Outex_SS_00000/' nfold '/filter.mat'],'Bw', 'Bt');
fprintf('iter: %i\n',i);wf
end

for i = 10:99
nfold = ['0' int2str(i)];
[Bw,Bt] = buildSupervisedTextureFilterBank(nfold,params,[.2 .07]);
save(['../Outex_SS_00000/' nfold '/filter.mat'],'Bw', 'Bt');
fprintf('iter: %i\n',i);
end

