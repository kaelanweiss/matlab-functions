function pos = axgridpos(nf,mf,i,pad,varargin)
% Function to calculate position of axes in a grid given dimensions of grid
% and inner/outer padding values. This is meant to give better results than
% the native "subplot." The function returns a position vector which can
% then be used to create axes.
%
% pos = axgridpos(nf,mf,i,pad)
% pos = axgridpos(nf,mf,i,pad,flip)
% pos = axgridpos(nf,mf,i,pad,shift)
% pos = axgridpos(nf,mf,i,pad,shift,flip)
%
% Input
%   nf: number of rows
%   mf: number of columns
%   i: index of axes (defaults to row-wise counting)
%   pad: padding vector in normalized units [x y x_outer y_outer] where
%   x_outer and y_outer are optional, default to x and y if not specified
%   flip: (optional) input 'flip' to count axes column-wise
%   shift: (optional) two-element vector of x and y shifts for all axes
%
% KJW
% 17 Jan 2023
%
% To-do
% - make padding input a vector with length 2 or 4
% - add shift option as a length 2 vector

% catch some errors
if (round(nf)~=nf || nf<1) || (round(mf)~=mf || mf<1)
    error('"nf" and "mf" must be positive integers')
end

if round(i)~=i || i<1 || i>nf*mf
    error('"i" must be an integer between 1 and nf*mf')
end

if length(pad) ~= 2 && length(pad) ~= 4
    error('pad vector must have 2 or 4 elements')
end

% parse pad
pdx = pad(1);
pdy = pad(2);
if length(pad) == 2
    pdx_outer = pdx;
    pdy_outer = pdy;
else
    pdx_outer = pad(3);
    pdy_outer = pad(4);
end


% parse varargin
flip = false;
flip_idx = strcmp(varargin,'flip');
if any(flip_idx)
    flip = true;
end

rem_args = varargin(~flip_idx);

if isempty(rem_args) % one input and it's 'flip'
    shift = [0 0];
elseif ~isempty(rem_args) % one input and it's not 'flip'
    shift = rem_args{1};
end

if ~isvector(shift) || length(shift) ~= 2
    error('shift vector must have 2 numerical elements')
end

% coordinates of axes in the grid (bottom left is (0,0))
if ~flip
    p = mod((i-1),mf); % horizontal
    q = floor((mf*nf-i)/mf); % vertical
else % flip
    p = floor((i-1)/nf);
    q = mod(mf*nf-i,nf);
end

% height and width
width = (1-2*pdx_outer-(mf-1)*pdx)/mf;
height = (1-2*pdy_outer-(nf-1)*pdy)/nf;

% lower left position
x = pdx_outer + p*(width+pdx) + shift(1);
y = pdy_outer + q*(height+pdy) + shift(2);

pos = [x y width height];

