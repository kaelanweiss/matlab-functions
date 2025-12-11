function dist = gcDist(lat,lon,lat0,lon0,varargin)
% Function to calculate the great circle distance between the points
% (lat,lon) and a reference point (lat0,lon0). Earth radius of 6.4e6 m is
% used, but sphere radius can be changed through optional input. To avoid
% problems with numerical precision, haversines are used when calculating
% the central angle between points. For more information, see 
% https://en.wikipedia.org/wiki/Great-circle_distance
%
% dist = gcDist(lat,lon,lat0,lon0)
% dist = gcDist(lat,lon,lat0,lon0,radius)
%
% Input (all lat/lon are dec deg)
%   lat: latitude of point(s)
%   lon: longitude of point(s)
%   lat0: latitude of reference point
%   lon0: longitude of reference point
%   radius: (optional) radius of spherical body, default 6.4e6 m for Earth
%
% Output:
%   dist: great circle distance between points
%
% KJW
% 11 Dec 2025

% parse varargin
if isempty(varargin)
    radius = 6.4e6; % m
else
    radius = varargin{1};
end

% convert inputs to radians
lat = lat*pi/180;
lon = lon*pi/180;
lat0 = lat0*pi/180;
lon0 = lon0*pi/180;

% calculate haversine of central angle
dlon = lon-lon0;
dlat = lat-lat0;
hav = sin(dlat/2).^2 + cos(lat).*cos(lat0).*sin(dlon/2).^2;

% central angle
cent_angle = 2*asin(sqrt(hav));

% distance
dist = radius*cent_angle;
