function [binned, tbins] = time_bin(time,data,dt,varargin)
% Function to compute bin-averages. Time dimension of input should be
% last. Currently works for 2 or 3 dimensions.
%
% [binned, tbins] = time_bin(time,data,dt)
% [binned, tbins] = time_bin(time,data,dt,nanflag)
% 
% Input
%   time: time vector
%   data: array to time bin, time dimension should be last
%   dt: time bin interval (in time input units)
%   nanflag: (optional) if 'omitnan', averaging functions called with
%       'omitnan' option
%
% KJW
% SUNRISE 2022

if nargin==4 && strcmp(varargin{1},'omitnan')
    mean2 = @(dat,dim) mean(dat,dim,'omitnan');
else
    mean2 = @(dat,dim) mean(dat,dim);
end

% dimensions
dims = size(data);
ndims = length(dims);

% bins
nbins = ceil(diff(time([1 end]))/dt);

% preallocate
dims2 = [dims(1:end-1) nbins];
binned = NaN(dims2);
if isdatetime(time)
    tbins = NaT(1,nbins);
else
    tbins = NaN(1,nbins);
end

% calculate
for i = 1:nbins
    t1 = time(1)+dt*(i-1);
    t2 = t1 + dt;
    idx = (time>=t1 & time<t2);
    tbins(i) = t1;
    
    % could generalize dimensions in future
    if ndims==2
        binned(:,i) = mean2(data(:,idx),2);
    elseif ndims==3
        binned(:,:,i) = mean2(data(:,:,idx),3);
    end
end
    