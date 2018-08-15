function tCoeffs = CoeffThresholding(thresh, coeffs)
%COEFFTHRESHOLDING determines which transformation coefficicients to shrink
%based on either universal thresholding (VisuShrink) or subband
%threshholding (BayesShrink)
%
% Note: other compression algorithms can be added to this function (e.g
% SureSHRINK etc)
%
%   Parameters: 
%       thresh: integer specifying which algorithm to use for thresholding
%       coeffs: wavelet coefficients stored as row vectors with lowest level representation first  
%
%   Return: 
%       tCoeffs: thresholded coefficients stored in same format as coeffs
%       array
%
%Created by J.MORSE on Aug 15th, 2018


if thresh == 1
   tCoeffs = VisuSURE(coeffs);
else
   tCoeffs= BayesShrink(coeffs);
end

compressionFactor = sum(sum(coeffs~=0,2)+1)./sum(sum(tCoeffs~=0,2)+1)

end
    