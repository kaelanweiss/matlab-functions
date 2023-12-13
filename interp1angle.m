function vq = interp1angle(x,v,xq,varargin)
% Function to interpolate angles smoothly over the 360 --> 0 discontinuity.
% This is basically a complex version of the interp1 function. Inputs are
% in radians.
% 
% vq = interp1angle(x,v,xq)
% vq = interp1angle(x,v,xq,method)
% vq = interp1angle(x,v,xq,method,'extrap')
% vq = interp1angle(x,v,xq,method,extrapval)
%
% KJW
% 12 Sep 2022

% convert angle to complex number
z = cos(v) + 1i*sin(v);

% interpolate
if nargin == 3 % base use
    zq = interp1(x,z,xq);
elseif nargin == 4 % specify interpolation method
    zq = interp1(x,z,xq,varargin{1});
elseif nargin == 5 % specify extrapolation
    zq = interp1(x,z,xq,varargin{1},varargin{2});
end

% convert back to angle
vq = angle(zq);