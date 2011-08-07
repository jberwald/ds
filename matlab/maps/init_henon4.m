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
  
  radius = [R 2*R];                     % we've scaled the y direction...
end


function map = the_map(params)

  map = @(v) [ params(1) - (v(1))^2 + params(2)*v(2) ...
			   v(1) ];
  
end

