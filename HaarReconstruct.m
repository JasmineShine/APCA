function [reconstructedSignal] = HaarReconstruct(seed, updatedCoeffs, endLength)
%HAARRECONSTRUCT performs the inverse discrete wavelet transformation 
%
%   Parameters: 
%       seed: first level approximation coefficient stored in a column vector
%       updatedCoeffs: DWT detail coefficients
%       endlength: final size of time vector (must be a power of two)
%
%   Return: 
%       reconstructeSignal: returns signal in time domain as row vectors.
%
%Created by J.MORSE on Aug 14th, 2018


resolution = log2(size(seed,2));
scaleFactor = (2^(resolution/2));
if size(seed, 2) == endLength
    reconstructedSignal = seed;

else
    levelDetailCoeffs = updatedCoeffs(:,(2^resolution):((2^(resolution+1))-1));
    rescaledDetailCoeffs = levelDetailCoeffs*scaleFactor;
    odds = seed - rescaledDetailCoeffs;
    evens = 2*seed - odds; 
    upSampledValues(:,1:2:(2^(resolution+1))) = evens;
    upSampledValues(:,2:2:(2^(resolution+1))) = odds;
    reconstructedSignal = HaarReconstruct(upSampledValues, updatedCoeffs, endLength);

end 

