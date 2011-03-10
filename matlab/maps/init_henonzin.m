function mapobj = init_henonzin

  mapobj = struct;
  mapobj.params = [1.4 0.3];
  mapobj.mapfunc = @(params) the_map(params);
  mapobj.boxfunc = @(params) get_box(params);
  mapobj.space = 'Rn';

end


function [center radius] = get_box(params)

  center = [0 0];
  
  B = abs(params(2))+1;
  A = abs(params(1));
  R = (B + sqrt(B^2 + 4*A))/2;
  R = sup(R);
  
  radius = [R R];
end


function map = the_map(params)

% This computes the interval image of the Henon map
% H(x,y) = (a - x^2 + b*y, x) where x, y, a, b are intervals.
% returns the Henon map for the given parameters
% [f_x(x,y) f_y(x,y)]

  map = @(v) [ params(1) - v(1) * v(1) + params(2) * v(2) ...
			   v(1) ];
end

