function out = nrm(v,varargin)
% Function to normalize data set (v) to factor (f)
% format: nrmed = nrm(v) or nrm(v,f)
% helpful for plotting data sets with disparate ranges on same time and y
% axes

% Kaelan Weiss 2018-07-23

if nargin > 1
    f = varargin{1};
elseif nargin == 1
    f = 1;
end

out = f*v/max(abs(v));

end