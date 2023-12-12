function [Y,CI,R2] = sinFitFT(t,y,varargin)
% Function to calculate a Fourier transform by fitting sines and cosines of
% Fourier components.

nan_limit = 0.5;

N = size(y,1);
T = diff(t([1 end]));

% Fourier frequencies up to Nyquist frequency
f = (1/T)*(0:floor(N/2))';
nf = length(f);


% Define fitting routine
foptions = fitoptions('method','nonlinearleastsquares','startpoint',[1 0]);
ftype = fittype('a*cos(2*pi*fj*x) + b*sin(2*pi*fj*x)','problem','fj','options',foptions);

% preallocate
ndim2 = size(y,2);
ndim3 = size(y,3);
Y = nan(size(y));
CI = squeeze(nan([size(y) 2]));
G = squeeze(nan([size(y) 2]));

% main loop
for i = 1:ndim2
    for j = 1:ndim3
        tij = t;
        yij = y(:,i,j);
        % remove nans
        nan_idx = isnan(yij);
        if sum(nan_idx)/N>nan_limit
            continue
        end
        
        tij(nan_idx) = [];
        yij(nan_idx) = [];

        % fitting loop
        for k = 1:length(f)
            if f(k)==0
                Y(1,i,j) = mean(yij) + 1i*0;
            else
                [fijk,gijk] = fit(tij,yij,ftype,'problem',f(k));
                cijk = confint(fij);
                % coefficients
                Y(k,i,j) = fijk.a + 1i*fijk.b;
                % confidence intervals
                CI(k,i,j,1) = cijk(1,1) + 1i*cijk(1,2);
                CI(k,i,j,2) = cijk(2,1) + 1i*cijk(2,2);
                % goodness stats
                G(k,i,j,
                zz = 5;
            end
        end

    end
end