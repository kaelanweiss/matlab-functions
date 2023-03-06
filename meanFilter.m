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
%
% Output
%   out: filtered vector

N = length(in);
nan_cutoff = 0.5;
out = nan(size(in));

omitnan = false;
if nargin == 3 && strcmpi(varargin{1},'omitnan')
    omitnan = true;
end

assert(mod(k,2)==1,'k must be odd');
assert(N>2*k,'k too large compared to N');

for i = ((k+1)/2) : N-((k-1)/2)
    idx = [-1 1]*(k-1)/2 + i;
    slicei = in(idx(1):idx(2));
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