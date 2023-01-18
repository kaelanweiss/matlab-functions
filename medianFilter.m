function out = medianFilter(in,k)
% Function: median filter of width k for 1D array in.
% out = medianFilter(in,k)
% Input
%   in: vector to be filtered
%   k: width of window
%
% Output
%   out: filtered vector

N = length(in);
nan_cutoff = 0.5;
out = NaN(size(in));

assert(mod(k,2)==1,'k must be odd');
assert(N>2*k,'k too large compared to N');

for i = ((k+1)/2) : N-((k-1)/2)
    idx = [-1 1]*(k-1)/2 + i;
    slicei = in(idx(1):idx(2));
    nNan = length(find(isnan(slicei)));
    if nNan/k < nan_cutoff
        out(i) = median(slicei,'omitnan');
    else
        out(i) = NaN;
    end
end