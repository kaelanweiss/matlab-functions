function [Pbin,fbin,M,S_ci] = progressiveBin(f,P,nf,nf_stops)
% Function to perform progressive binning of PSDs, inputs should be column
% vectors (f and P)
%
% Example:
%   f ranges from 0 to 100 and we want to use bin widths of 4 up to f=50
%   and 8 beyond f=50, the nf=[0,50], nf_stops=[4,8]
%
% [Pbin,fbin,M,S_ci] = progressiveBin(f,P,nf,nf_stops)
%
% Input
%   f: frequency vector (or independent variable)
%   P: power spectral density (or dependent variable)
%   nf: number of values to average
%   nf_stops: locations along f (independent variable) at which to use bin
%   widths specified by nf
%   
% Output
%   Pbin: binned power spectral density (or dependent variable)
%   fbin: center of frequency bins
%   M: number of degrees of freedom in each spectral bin (2*number of
%   values)
%   S_ci: spectral confidence interval (95%) as a factor of Pbin
%
% KJW
% 12 Apr 2025

% useful values
n_stops = length(nf);
df = diff(f(1:2));

% preallocate
Pbin = [];
fbin = [];
M = []; % degrees of freedom

% flip columns to rows
if iscolumn(f)
    f = f';
end
if iscolumn(P)
    P = P';
end

% loop through bin widths
nf_stops(end+1) = Inf;
for i = 1:n_stops
    idxf = f>=nf_stops(i) & f<nf_stops(i+1);
    [Pi,fi] = time_bin(f(idxf)',P(:,idxf),nf(i)*df);
    Mi = 2*nf(i)*ones(size(fi));
    Pbin = [Pbin; Pi'];
    fbin = [fbin; fi'+0.5*diff(fi(1:2))];
    M = [M; Mi'];
end

% confidence interval
alpha = 0.05;
S_ci = [M./chi2inv(1-alpha/2,M) M./chi2inv(alpha/2,M)];
