function tCoeffs = BayesShrink(coeffs)
%BAYESSHRINK applies a subband-specific threshold to shrink DWT detail coefficients for data compression and/or denoising 
%
%   Chang, S. G., Yu, B. and Vetterli, M. (2000). Adaptive wavelet thresholding 
%   for image denoising and compression. IEEE transactions on image processing: 
%   a publication of the IEEE Signal Processing Society 9(9), 1532–1546.
% 
%   Parameters: 
%       coeffs: scaled detail coefficients stored as row vectors
%
%   Return: 
%       coeffs: updated coeffs array with thresholded wavelet coefficients
%
%Created by J.MORSE on Aug 15th, 2018

[nrow ncol] = size(coeffs);
tCoeffs = zeros(nrow, ncol);

level = (log2(size(coeffs,2)))-1;
noise= coeffs(:,(2^level)+1:((2^(level+1))));

for i = 1:size(coeffs,1)
    varNoise = (mad(noise(i,noise(i,:)~=0))/0.6745)^2;
    
    traceCoeff = zeros(1,2^(level+1));
    for j = 0:level
        if j == 0
            sIndex = 2^j;
        else 
            sIndex = (2^j)+1;
        end 
        levelCoeffs = coeffs(i,sIndex:(2^(j+1)));
        subBandDev = sqrt(max(var(levelCoeffs(levelCoeffs~=0))-varNoise,0));
        bayesT = varNoise/subBandDev;
        levelCoeffs(abs(levelCoeffs)<bayesT) = 0; 
        traceCoeff(sIndex:(2^(j+1))) = levelCoeffs;
    end 
    tCoeffs(i,:) = traceCoeff;
end
end 
    