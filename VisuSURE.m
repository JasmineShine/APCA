function coeffs = VisuSURE(coeffs)
%VISUSURE applies the same universal threshold to detail coefficients at
%   each level of the DWT for data compression  
%
%   Donoho, D. L. and Johnstone, J. M. (1994). Ideal spatial adaptation by 
%   wavelet shrinkage. Biometrika 81(3), 425–455.
% 
%   Parameters: 
%       coeffs: scaled detail coefficients stored as row vectors
%
%   Return: 
%       coeffs: updated coeffs array with thresholded wavelet coefficients
%
%Created by J.MORSE on Aug 15th, 2018

j = (log2(size(coeffs,2)))-1;
noise_coeffs = coeffs(:,(2^j)+1:((2^(j+1))));

for i = 1:size(coeffs,1)
    sigma_mad = mad(noise_coeffs(i,(noise_coeffs(i,:)~=0)))/0.6745; 
    donohoT = sigma_mad.*sqrt(2*log(size(coeffs,2))); %Universal thershold using an estimator of noise from wavelet coeffs    
    coeffs(i,(abs((coeffs(i,:)))<donohoT))= 0;
end
end 