function p = plotConfidenceRegion(ax,t,f_low,f_high,clr,alpha,varargin)
% Function to plot a shaded confidence region defined by lower and upper
% bounds on a function f(t).
%
% p = plotConfidenceRegion(ax,t,f_low,f_high,clr,alpha)
% p = plotConfidenceRegion(ax,t,f_low,f_high,clr,alpha,dep_axis)
%
% Input
%   ax: axes object
%   t: independent variable
%   f_low: lower confidence limit of dependent variable
%   f_high: upper confidence limit of dependent variable
%   clr: region color
%   alpha: region alpha
%   dep_axis: (optional) 'x' if confidence intervals applied to the
%       horizontal axis, default 'y' or vertical axis
%
% KJW
% 31 Jul 2025

% parse varargin
dep_axis = 'y';
switch nargin
    case 1
        if strcmpi(varargin{1},'x')
            dep_axis = 'x';
        end
end

% turn row vectors into column vectors
if isrow(t)
    t = t';
end
if isrow(f_low)
    f_low = f_low';
    f_high = f_high';
end

% find blocks around nan values
blks = findBlocks(~isnan(f_low+f_high));
n_blks = size(blks,1);

% loop through blocks of good data
for i = 1:n_blks
    idx = blks(i,1):blks(i,2);
    % set up patch vertices
    t_patch = [t(idx); flip(t(idx))];
    f_patch = [f_low(idx); flip(f_high(idx))];
    
    switch dep_axis
        case 'y'
            x_patch = t_patch;
            y_patch = f_patch;
        case 'x'
            x_patch = f_patch;
            y_patch = t_patch;
    end
    
    % plot
    p(i) = patch(ax,x_patch,y_patch,clr,'facealpha',alpha,'edgecolor','none');
    
end

