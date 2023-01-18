function [out, idx] = sigmaFilter(in,nsigma,dim,npasses,varargin)
% Function to find and replace values in a matrix outside of a window
% defined by standard deviations.
% [out, idx] = sigmaFilter(in,nsigma,dim,npasses)
% Input
%   in: n-dimensional matrix of values to filter
%   nsigma: standard deviations outside of which values are filtered
%   dim: dimensional along which to perform filtering
%   npasses: number of passes to recursively filter
%   interp_flag: (optional) 
% Output
%   out: n-dimensional filtered matrix 
%   idx: n-dimensional logical matrix with filtered values 'true'

sz = size(in);
N = sz(dim);
idx = false(sz);
out = in;
pass = 1;
while pass <= npasses
    [out, idxh] = helper(out);
    idx = idx | idxh;
    pass = pass + 1;
end

% filter sub-function
function [outh, idxh] = helper(inh)
    % calculate mean
    mu = mean(inh,dim,'omitnan');
    repvec = ones(1,length(sz));
    repvec(dim) = N;
    % calculate variance
    variance = (inh-repmat(mu,repvec)).^2;
    % std
    sigma = sqrt(sum(variance,dim,'omitnan')/(N-1));
    % find bad values
    idxh = sqrt(variance)>nsigma*repmat(sigma,repvec);
    % NaN them out
    inh(idxh) = NaN;
    outh = inh;
end

end
    