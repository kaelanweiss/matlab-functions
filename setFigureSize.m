function fig = setFigureSize(fig,figsize)
% Function to set the size of a figure in centimeters.
%
% fig = setFigureSize(fig,figsize)
%
% Input
%   fig: figure object
%   figsize: [width height] in cm
% 
% Output
%   fig: updated figure handle
%
% KJW
% 4 Sep 2024

set(fig,'units','centimeters'); 
fpos = get(fig,'position');
fpos(3:4) = figsize;
set(fig,'position',fpos);
set(fig,'paperunits','centimeters')
set(fig,'papersize',figsize)