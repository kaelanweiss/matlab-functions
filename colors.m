function c = colors(n)
% Function that returns the nth default plot color.
% 
% Format: c = colors(n)
%
% There are seven colors so n wraps around as such:
% n = mod(n-1,7) + 1
% c is a 1-by-3 rgb vector with elements in [0,1]
%
% Kaelan Weiss 2018-07-24

n = mod(n-1,7)+1;

COLORS = {[0.000,0.447,0.741]; ...
          [0.850,0.325,0.098]; ...
          [0.929,0.694,0.125]; ...
          [0.494,0.184,0.556]; ...
          [0.466,0.674,0.188]; ...
          [0.301,0.745,0.933]; ...
          [0.635,0.078,0.184]};

c = COLORS{n};

end