function [u,v] = TVG_CartoonTexture(f)
%==========================================================================
% function [u,v] = TVG_CartoonTexture(f)
%
% TV-G Cartoon + Texture decomposition
% Version:
% -v1.0 - 10/30/2011
%
% This function performs Meyer's Cartoon + Texture decomposition of an
% image based on Aujol's formulation by Split Bregman Iterations
%
% Reference: J.Gilles, S.Osher, "Bregman implementation of Meyer's 
%            G-norm for cartoon + textures decomposition" available as 
%            UCLA-CAM Report CAM11-73
%
%Inputs:
%   -f: input image (must be normalized between 0 and 1).
%
%Outputs:
%   -u: the cartoon part.
%   -v: the texture part.
%
%Remarks:
%   -this function is just a slight modification of the
%   TVG_CartoonTexture_Decomposition function that you can find in the
%   Bregman Cookbook.
%
% Author: Jerome Gilles
% Institution: UCLA - Math Department
% email: jegilles@math.ucla.edu
%
%07/02/2015 by Valentin De Bortoli (ENS Cachan, France)
%==========================================================================
u=zeros(size(f));
v=zeros(size(f));

mu=size(f,1)/2;
lambda=Estimate_Low_Frequency_Bound(f);
Breglambda=100;
err=norm(f(:),2);
tol=1e-3*norm(f(:),2);
Niter=10;
n=1;
while err>tol && n<Niter
    up=u;
    vp=v;
    
    %update u
    tmp=f-v;
    u=ITV_ROF(tmp,lambda,Breglambda,Niter);

    %update v
    tmp=f-u;
    v=ITV_ROF(tmp,1/mu,Breglambda,Niter);
    v=tmp-v;
    
    err=max(sum(sum((u-up).^2)),sum(sum((v-vp).^2)));
    n=n+1;
end