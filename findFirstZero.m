function [x0,idx1] = findFirstZero(x,y)
% Function to find the x coordinate of the first zero crossing of a vector
% y by linear interpolation.
% 
% [x0,idx1] = findFirstZero(x,y)
% 
% KJW
% 22 May 2022

% all positive or all negative --> no zero crossing
if all(y<0) || all(y>0)
    x0 = [];
    idx1 = [];
    return
end

% check for actual zeroes
if any(y==0)
    idx1 = find(y==0,1);
    x0 = x(idx1);
    return
end

% find first index where y_i*y_(i+1) < 0
n = length(y);
idx1 = find(y(1:(n-1)).*y(2:n)<0,1);
x1 = x(idx1);
x2 = x(idx1+1);
y1 = y(idx1);
y2 = y(idx1+1);
m = (y2-y1)/(x2-x1);

x0 = x1-y1/m;


