function [scaledCoeff] = ScaleCoefficients(coeffArray)
%SCALECOEFFICIENTS normalizes haar wavelet transformation according to resolution level of each coefficient
%
%   Parameters: 
%       coeffArray: row vectors containing detail coefficients of a wavelet transformation 
%       
%   Return: 
%       scaledCoeff: row vector containing scaled detail coefficients
%
%Created by J.MORSE on Aug 15th, 2018

levels = log2(size(coeffArray,2))-1;
for j = 0:(levels) 
    scaledCoeff(:,(2^j)+1:(2^(j+1))) = coeffArray(:,(2^j)+1:(2^(j+1)))./(2^((j)/2));
end 
scaledCoeff(:,1) = coeffArray(:,1);
end 