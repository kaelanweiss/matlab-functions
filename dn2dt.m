function time = dn2dt(time)
% Function to streamline converting datenum data to datetime data.
%
% time = dn2dt(time)
%
% Input
%   time: matrix of time in datenum format
%
% Output
%   time: matrix of time in datetime format
%
% KJW
% 1 Feb 2023

if ~isdatetime(time(1))
    time = datetime(time,'convertfrom','datenum');
else
%     warning('Input is already datetime.')
end