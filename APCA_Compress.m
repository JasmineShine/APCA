
function [signalReconstruct] = APCA_Compress(signal,thresh)
%APCA_COMPRESS Return Adaptive Piecewise Constant Approximation (APCA)of time series data  
%
%   Keogh, E., Chakrabarti, K., Pazzani, M. and Mehrotra, S. (2001). 
%   Locally adaptive dimensionality reduction for indexing large time series 
%   databases. ACM SIGMOD Record 30(2), 151–162.
%   
%   Keogh, E., Chakrabarti, K., Pazzani, M. and Mehrotra, S. (2002). 
%   Locally adaptive dimensionality reduction for indexing large time series 
%   databases. ACM Transactions on Database Systems 27(2), 188–228.
% 
%   Parameter: 
%       signal: array containing processed time series data. Each time
%       series assumed to be stored as a row vector.
%
%       thresh: integer index for thresholding algorithm used in Haar wavelet 
%       transformation. Use 1 for VisuSURE, else BayesShrink. 
%
%   Return:
%       signalReconstruct: array containing APCA representation of data
%       set. Each time series stored as a row vector. 
%
% Created by J.MORSE on Aug 14th, 2018


[nTraces,nFrames] = size(signal);

% Pad data with zeros so the length is a power of 2. Necessary for haar
% DWT.
padLen = 2^nextpow2(nFrames) - nFrames;
signal = [ signal zeros(nTraces,padLen) ];

% Extract haar coefficients from data and scale according to resolution
% level
haarCoefficients = HaarFilter(signal);
scaledCoefficients = ScaleCoefficients(haarCoefficients);

%determine number of coefficients to keep
sparseCoefficients = CoeffThresholding(thresh, scaledCoefficients);

% Reconstruct signal using thresholded coefficients 
seeds = sparseCoefficients(:,1);
details = sparseCoefficients(:,2:end);
signalReconstruct = HaarReconstruct(seeds, details, size(signal,2));

% Truncate reconstructed signal to length of the original trace
signalReconstruct = signalReconstruct(:,1:nFrames);

% Replace approximate segment mean values with exact mean values from raw
% data
for t=1:nTraces
    statemean = unique(signalReconstruct(t,:) );
    
    for s=1:numel(statemean)
        sel = signalReconstruct(t,:)==statemean(s); 
        signalReconstruct(t,sel) = mean(signal(t,sel) );
    end
end

%plot example traces
nfigures = min(nTraces,5);
figure

for i = 1:nfigures
    subplot(nfigures,1,i)
    hold on
    ylim([-0.2,1.2])
    xlim([0,600])
    plot(signal(i,:))
    plot(signalReconstruct(i,:))
end

end


