function mapobj = init_henon4

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
  R = (B + sqrt(B^2 + 4*A));
  R = sup(R);
  
  radius = [R*2 R];                     % we've scaled the x direction...
end


function map = the_map(params)

% This computes the interval image of the SCALED Henon map
% H(x,y) = ( (a - (g(y)x)^2 + b*y)/g(g(y)x), g(y)x ) where x, y, a, b are intervals.
% here g(y) = C
  C=0.5;
  map = @(v) [ params(1)/C - C*(v(1))^2 + params(2)*v(2)/C ...
			   C*v(1) ];
  
end

