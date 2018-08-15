function [pairWiseAverage distanceCoeffs] = GetHaarCoefficients (dataArray)
%GETHAARCOEFFICIENTS determines one level of the haar wavelet transform,
%providing approximation and detail coefficients.
%   
%   Parameters: 
%       dataArray: array containing data set as row vectors
%   
%   Return:
%       pairWiseAverage: row vector storing approximation coefficients 
%       distance coeffs: row vector storing detail coefficients 
%
%Created by J.MORSE on Aug 15th, 2018


if nextpow2(size(dataArray,2))~= log2(size(dataArray,2))
    msg = 'Data length is not a power of two'
    error(msg)
end 

firstValue = dataArray(:,1:2:(size(dataArray,2)-1));
secondValue = dataArray(:,2:2:(size(dataArray,2)));
pairWiseAverage = (firstValue + secondValue)./2;
distanceCoeffs = pairWiseAverage - secondValue;

end 