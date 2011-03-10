
function map = henon_map(params)

% This computes the interval image of the Henon map
% H(x,y) = (a - x^2 + b*y, x) where x, y, a, b are intervals.
% returns the Henon map for the given parameters
% [f_x(x,y) f_y(x,y)]

  map = @(v) [ params(1) - v(1) * v(1) + params(2) * v(2) ...
			   v(1) ];
