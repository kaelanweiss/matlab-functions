function [out, idx] = runningSigmaFilter(in,nsigma,npass,width,ovrlp,varargin)
% Function to perform a running sigma filter.
%
% [out, idx] = runningSigmaFilter(in,nsigma,npass,width,ovrlp)
% [out, idx] = runningSigmaFilter(in,nsigma,npass,width,ovrlp,detrend_flag)
%
% Input
%   in: 1D or 2D array, filtering is applied to columns
%   nsigma: number of standard deviations beyond which to filter out
%   npass: number of filter passes per window
%   width: width of window
%   ovrlp: overlap width of window
%   detrend_flag: (optional) default true, set false to skip detrending
%
% Output
%   out:
%   idx:
%
% KJW
% 27 Mar 2025

% varargin
detrend_flag = true;
if nargin == 6
    assert(islogical(varargin{1}),'detrend_flag must be logical')
    detrend_flag = logical(varargin{1});
end

% input size
[nr,nc] = size(in);

% check input
assert(width > ovrlp,'overlap must be less than window width')

% preallocate
out = in;
idx = false(size(in));

% window parameters
inc = width - ovrlp;

% loop through columns
for i = 1:nc
    % reset position for each column
    pos1 = 1;
    pos2 = width;

    while pos2 <= nr
        % get slice
        slice = in(pos1:pos2,i);
        % detrend
        if detrend_flag
            slice = detrend(slice);
        end
        % find outliers
        [~,s_idx] = sigmaFilter(slice,nsigma,1,npass);
        % compare overlapping values, keep if found in both
        ovrlp_values = idx(pos1:pos1+ovrlp-1,i);
        s_idx(1:ovrlp) = s_idx(1:ovrlp) & ovrlp_values;
        % keep track
        idx(pos1:pos2,i) = idx(pos1:pos2,i) | s_idx;
        a = 5;
        % move to next window
        pos1 = pos1 + inc;
        pos2 = pos2 + inc;
    end

    % if pos2 > nc and more than 5 points left
    pos2 = nr;
    if nr - pos1 > 5
        % get slice
        slice = in(pos1:pos2,i);
        % detrend
        if detrend_flag
            slice = detrend(slice);
        end
        % find outliers
        [~,s_idx] = sigmaFilter(slice,nsigma,1,npass);
        % compare overlapping values, keep if found in both
        ovrlp_values = idx(pos1:pos1+ovrlp-1,i);
        s_idx(1:ovrlp) = s_idx(1:ovrlp) & ovrlp_values;
        % keep track
        idx(pos1:pos2,i) = idx(pos1:pos2,i) | s_idx;
    end
end

% remove outliers
out(idx) = nan;

