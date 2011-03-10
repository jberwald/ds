function mapobj = init_duop

  mapobj = struct;
  mapobj.params = [
	  0.17 %a
	  1.00 %b
	  0.9  %theta
				  ];
  mapobj.mapfunc = @(params) (@(v) the_map(v,params));
  mapobj.boxfunc = @(params) get_box(params);
  mapobj.space = 'Rn';

end

function [center radius] = get_box(p)
% yikes, I have no clue
  d = (p(1)+p(2))^2;
  %  center = [p(2)/d p(1)/d]; % the Courot point
  center = [0.5 0.5];
  radius = center;
end

function f = the_map(v, p)
  f=[ v(1) + p(3)*(sqrt(v(2)/p(1)) - v(2) - v(1)) ...
      v(2) + p(3)*(sqrt(v(1)/p(2)) - v(2) - v(1)) ];
end
