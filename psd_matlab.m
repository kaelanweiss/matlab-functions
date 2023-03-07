function [P,f] = psd_matlab(X,fs)
% 
%

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
