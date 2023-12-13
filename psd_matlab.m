function [P,f] = psd_matlab(X,fs,varargin)
% Calculate the one-sided power spectral density of a vector or columns of 
% a matrix. If the time dimension of the input has an odd number of 
% elements, a zero is appended to make coding easier. A Hanning window is 
% applied to the input before calculating the DFFT (unless 'notaper' is 
% specified). Based off of Matlab's FFT documentation.
%
% [P,f] = psd_matlab(X,fs)
% [P,f] = psd_matlab(X,fs,'notaper')
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

% size (add a row of zeros if length is odd)
n = size(X,1);
if mod(n,2) % is odd
    X = cat(1,X,zeros(1,size(X,2)));
    n = n + 1;
end

% hanning window if so desired
if nargin > 2 && strcmpi(varargin{1},'notaper')
    H = ones(size(X));
else
    H = repmat(hann(n),[1 size(X,2)]);
end

% DFFT (with taper renormalization)
Y = fft(H.*X)/sqrt(mean(H.^2,'all'))/n;
f = fs*(0:(n/2))/n;
df = fs/n;

% one-sided PSD
P2 = conj(Y).*Y/df;
P = P2(1:n/2+1,:);
P(2:end-1,:) = 2*P(2:end-1,:);
