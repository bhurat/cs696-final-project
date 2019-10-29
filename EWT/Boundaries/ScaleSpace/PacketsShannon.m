%%%%%%
%author: Basile Hurat
%
function [B,th] = PacketsShannon(f,lengths,indices)
global B
method = 'shannon';

%Calculate entropy of original signal
node.entrop = wentropy(ifft(f),method);

%Half signal to one side
signal_half = round(size(f,1)/2);
f = f(signal_half+1:end);
fsize = size(f,1);
interval = indices >= signal_half;
lengths = lengths(interval);
indices = indices(interval) - signal_half;

%Introduces entropy method and start tree

node.bounds = [1 fsize];
%B for storing boundaries

B = [];
%recursively create tree
spawntree(node, f, lengths, indices, method);
%th = lengthsB);
end

%Function for recursively creating tree
function spawntree(node,f, lengths, indices, method)
global B
fsize = size(f,1);
%Look at only lengths and indices in current bound
a = node.bounds(1); b = node.bounds(2);
interval = and(indices >=a,indices < b);
regindices = indices(interval);
reglengths = lengths(interval);

%Sort longest length for next boundary
[temp, order] = sort(reglengths,'descend');
regindices = regindices(order);
if isempty(regindices) 
    return
end

%Create filters (Haar)
filter_left = and(1:fsize  > a, 1:fsize  < regindices(1));
%filter_left = EWT_Meyer_Wavelet(a,regindices(1),.01,size(f,1));
filter_right = and(1:fsize  >= regindices(1), 1:fsize <= b);
%filter_right = EWT_Meyer_Wavelet(regindices(1),b,.01,size(f,1));
sig2a = wentropy(ifft(f.*filter_left,'symmetric'),method);

sig2b = wentropy(ifft(f.*filter_right,'symmetric'),method);


if sig2a + sig2b < node.entrop
    B = [B regindices(1)];
    lchild.entrop = sig2a;
    lchild.bounds = [a regindices(1)-1];
    node.left = lchild;
    
    rchild.entrop = sig2b;
    rchild.bounds = [regindices(1)+1 b];
    node.right = rchild;
    spawntree(lchild,f,lengths,indices,method);
    spawntree(rchild,f,lengths,indices,method);

end

end
