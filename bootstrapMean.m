function [x_mean,ci] = bootstrapMean(x,alpha,n,varargin)
% Function to calculate the mean and bootstrap interval of the mean for a
% set of estimates. Variance can be specified for variance-weighted mean.
%
% [mean,c_low,c_high] = bootstrapMean(x,alpha,n)
% [mean,c_low,c_high] = bootstrapMean(x,alpha,n,'x_var',x_var)
%
% Input
%   x: vector of estimates
%   alpha: confidence level (e.g. .05 for 95% confidence)
%   n: bootstrap resamples
%   x_var: (optional) variance of elements of x
%
% Output
%   x_mean: mean of x (median of dist?)
%   ci: confidence interval at specified confidence level
%
% KJW
% 12 Dec 2025

% parse variance inputs
p = inputParser;
addParameter(p,'x_var',ones(size(x)));
parse(p,varargin{:});
x_var = p.Results.x_var;

% weighted flag
wgtd = ~all(x_var==1);

% setup
nx = length(x);
rs_mean = nan(n,1);

if wgtd
    % weighted mean
    for i = 1:n
        idxi = randi(nx,[nx 1]);
        x_rs = x(idxi);
        var_rs = x_var(idxi);
        rs_mean(i) = varWgtMean(x_rs,var_rs);
    end
else
    % unweighted mean
    for i = 1:n
        x_rs = x(randi(nx,[nx 1]));
        rs_mean(i) = mean(x_rs,'omitnan');
    end
end

% sort
sort_mean = sort(rs_mean);

% extract statistics from sorted resampled means
idx_mean = [floor(n/2) ceil(n/2)];
idx_ci = [round(alpha*n) round((1-alpha)*n)];

x_mean = mean(sort_mean(idx_mean));
ci = sort_mean(idx_ci);
