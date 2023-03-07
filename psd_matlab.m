function [P,f] = psd_matlab(X,fs)
% Calculate the one-sided power spectral density of a vector or columns of 
% a matrix. A Hanning window is applied to the input before calculating the
% DFFT. Based off of Matlab's FFT documentation.
%
% [P,f] = psd_matlab(X,fs)
%
% Input
%   X: input signal, PSD applied to column(s), must be 1 or 2-dimensional
%       at the moment
%   fs: sample frequency
%
% Output
%   P: power spectral density, same size as X
%   f: frequency vector associated with first dimension of P
%
% KJW
% 6 Mar 2023

% size
nt = size(X,1);
n = 2^nextpow2(nt);

% hanning window
H = repmat(hann(nt),[1 size(X,2)]);

% DFFT
Y = fft(H.*X);
f = fs*(0:(n/2))/nt;

% one-sided PSD
P2 = abs(Y/n);
P = P2(1:n/2+1,:);
P(2:end-1,:) = 2*P(2:end-1,:);

% trim to Nyquist
f = f(1:(ceil(nt/2)+1));
P = P(1:(ceil(nt/2)+1),:);
