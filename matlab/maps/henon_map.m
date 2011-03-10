
function map = henon_map(params)

% returns the Henon map for the given parameters
% [f_x(x,y) f_y(x,y)]

  map = @(v) [1 - params(1) * v(1) * v(1) + v(2) ...
			  params(2) * v(1)];
