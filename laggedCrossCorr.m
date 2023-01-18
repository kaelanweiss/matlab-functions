function [rho,N] = laggedCrossCorr(x1,x2,k)
% Function to calculate the cross-correlation between two vectors.
% rho = crossCorrelation(x1,x2,k)
% Input
%   x1: first vector
%   x2: second vector
%   k: number of lags in both directions
% Output
%   rho: cross-correlation vector with 2k+1 values centered at zero lag
%   N: number of value pairs at each lag
% ---Note: the normalization at the end *(Ni/nx) is hand wavy and I'm not
% sure why I had to include this to get the tapered

% preallocate
rho = NaN(2*k+1,1);
N = NaN(2*k+1,1);

% flip inputs to column vectors
if isrow(x1)
    x1 = x1';
end
if isrow(x2)
    x2 = x2';
end

% pad shorter vector with NaNs to simplify the algorithm
nx1 = length(x1);
nx2 = length(x2);
if nx1>nx2
    x2 = [x2;NaN(nx1-nx2,1)];
elseif nx1<nx2
    x1 = [x1;NaN(nx2-nx1,1)];
end
nx = nx1;

for i = -k:k
    pos = i+k+1; % position in output
    % determine overlap windows
    if i > 0
        idx1 = 1:(nx-i);
        idx2 = (i+1):nx;
    elseif i <= 0
        idx1 = (1-i):nx;
        idx2 = 1:(nx+i);
    end
    % get slices
    x1i = x1(idx1);
    x2i = x2(idx2);
    % clean out bad values
    bad1 = isnan(x1i);
    bad2 = isnan(x2i);
    %fprintf('%d: idx1 = [%d, %d] idx2 = [%d, %d]\n',i,idx1(1),idx1(end),idx2(1),idx2(end));
    badi = bad1 | bad2;
    x1i(badi) = [];
    x2i(badi) = [];
    % find length of each slice after cleaning
    Ni = length(x1i);
    assert(length(x1i)==length(x2i),'cleaned vector lengths don''t match');
    N(pos) = Ni;
    if Ni < 3
        continue
    end
    % calculate stats
    mu1 = mean(x1i);
    mu2 = mean(x2i);
    sig1 = std(x1i,1);
    sig2 = std(x2i,1);
    % calculate cross-correlation
    R = (1/Ni)*(x1i-mu1)'*(x2i-mu2);
    rho(pos) = R/(sig1*sig2);%*(Ni/nx);
end

end