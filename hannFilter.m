function out = hannFilter(in,k,varargin)
% Function: Hanning window filter of width k for 1D array in.
%
% out = hannFilter(in,k)
% out = hannFilter(in,k,nanflag)
%
% Input
%   in: vector to be filtered
%   k: width of window
%   nanflag: (optional) 'omitnan' to ignore nans in mean calculation
%
% Output
%   out: filtered vector

% find nans
idx_nan = isnan(in);

% set nans to zero in original vector
y0 = in;
y0(idx_nan) = 0;

% smooth using convolution of normalized Hanning window
w = hann(k)/sum(hann(k));
y0s = conv(y0,w,'same');

% calculate normalization by convolving logical ~nan vector
y1 = 1*~isnan;
y1s = conv(y1,w,'same');

% if there are too many nans, keep the nan value
nan_limit = 0.5;
y1s(y1s<nan_limit) = nan;

% normalize convolved input
out = y0s./y1s;