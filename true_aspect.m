function true_aspect(varargin)
% Function to equalize x- and y-spacing of a figure;
% true_aspect()
% true_aspect(figure_num)

if nargin == 0
    pbaspect([1 diff(extrema(ylim))/diff(extrema(xlim)) 1]);
elseif nargin == 1
    figure(varargin{1});
    pbaspect([1 diff(extrema(ylim))/diff(extrema(xlim)) 1]);
end