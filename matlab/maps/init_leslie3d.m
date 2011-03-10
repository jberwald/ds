function mapobj = init_leslie3d

  mapobj = struct;
  mapobj.params = [
	  80 % f1
	  80 % f2
	  80 % f3
	  0.1 % lambda
	  0.8 % p1
	  0.6 % p2
				  ];
  mapobj.mapfunc = @(params) the_map(params);
  mapobj.boxfunc = @(params) get_box(params);
  mapobj.space = 'Rn';

end

T (x, y, z) = ((f1x + f2y + f3z) 

function [center radius] = get_box(params)

  % ???
  center = [100 100 100];
  radius = center;

end


function map = the_map(params)

% returns the 3d Leslie map for the given parameters

% (f1x + f2y + f3z) e^(lambda(x+y+z)),  p1 x,  p2 y
map = @(v) [
	dot(params(1:3), v) * exp(-params(4)*sum(v)) ... 
	params(5) * v(1)
	params(6) * v(2)
		   ];
end

