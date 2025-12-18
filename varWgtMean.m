function [x_bar,std_err] = varWgtMean(x,x_var)
% Function to compute the variance-weighted mean of a vector. Weights for
% each element are given by 1/var_i, or the reciprocal of the variance
% (or uncertainty-squared). The standard error on the weighted mean is defined as
% the sqrt of the reciprocal of the  sum of the weights. See 
% https://en.wikipedia.org/wiki/Weighted_arithmetic_mean for more info.
% This implementation ignores NaNs.
%
% [x_bar,std_err] = varWgtMean(x,x_var)
%
% Input
%   x: vector of samples
%   x_var: vector of sample variance (or uncertainty-squared)
%
% Output
%   x_bar: variance weighted mean
%   std_err: standard error of the mean
%
% KJW
% 15 Dec 2025

% weights
w = 1./x_var;

% check for nans
idx = ~isnan(x) & ~isnan(x_var);
x = x(idx);
w = w(idx);

% mean
x_bar = sum(x.*w)/sum(w);

% std err
std_err = sqrt(1/sum(w));