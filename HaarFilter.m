function coeffs = HaarFilter(dataArray)
% HAARFILTER perform DWT using haar wavelet to a resolution level of 0
% 
%   Parameter: 
%       dataArray: array containing time series data to be transformed.
%       Each series stored as a row vector
%
%   Return: 
%       coeffs: haar wavelet coefficients starting in order with lowest level representation first. 
%
%Created by J.MORSE on Aug 14th, 2018


if size(dataArray,2) == 1
    coeffs = [dataArray];

else
    [averages, diff] = GetHaarCoefficients(dataArray);
    coeffs = [HaarFilter(averages),diff];
   
end 