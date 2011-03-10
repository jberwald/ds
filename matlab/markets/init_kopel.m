function mapobj = init_kopel

  mapobj = struct;
  mapobj.params = [
	  3.8    %mu
	  0.695  %theta
				  ];
  mapobj.mapfunc = @(params) the_map(params);
  mapobj.boxfunc = @(params) get_box(params);
  mapobj.space = 'Rn';

end

function [center radius] = get_box(p)
% yikes, I have no clue
  center = [1 1];
  radius = center;
end

function map = the_map(p)
  map = @(v) [ v(1) + p(2)*(p(1)*v(2)*(1 - v(2)) - v(1)) ...
               v(2) + p(2)*(p(1)*v(1)*(1 - v(1)) - v(2)) ];
end
