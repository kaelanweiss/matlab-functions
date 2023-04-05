function out = meanFilter(in,k,varargin)
% Function: mean filter of width k for 1D array in.
%
% out = meanFilter(in,k)
% out = meanFilter(in,k,nanflag)
%
% Input
%   in: vector to be filtered
%   k: width of window
%   nanflag: (optional) 'omitnan' to ignore nans in mean calculation
%   endpoints: (optional) 'keepends' to ignore nans in mean calculation
%
% Output
%   out: filtered vector

N = length(in);
nan_cutoff = 0.5;
out = nan(size(in));

% parse inputs
omitnan = false;
if nargin > 2 && any(strcmpi(varargin,'omitnan'))
    omitnan = true;
end

keepends = false;
if nargin > 2 && any(strcmpi(varargin,'keepends'))
    keepends = true;
end

% make sure k is okay for the given input vector
assert(mod(k,2)==1,'k must be odd');
assert(N>2*k,'k too large compared to N');

% main loop, this leaves endpoints as nans
for i = 1:N
    idx = (-(k-1)/2:(k-1)/2) + i;
    idx = intersect(1:N,idx);
    slicei = in(idx);
    nNan = length(find(isnan(slicei)));
    if nNan/k < nan_cutoff
        if omitnan
            out(i) = mean(slicei,'omitnan');
        else
            out(i) = mean(slicei);
        end
    else
        out(i) = NaN;
    end
end

% nan out ends if so desired (default)
if ~keepends
    idx = [1:(k-1)/2 N-(k-1)/2+1:N];
    out(idx) = nan;
end