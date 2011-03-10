function mapobj = init_logistic

  mapobj = struct;
  mapobj.params = 4;
  mapobj.mapfunc = @(params) the_map(params);
  mapobj.boxfunc = @(params) get_box(params);
  mapobj.space = 'Rn';

end


function [center radius] = get_box(params)

  center = 0.5;
  radius = 0.5;
end


function map = the_map(params)

% returns the logistic map for the given parameters
% f(x) = a x (1-x)

  map = @(v) [params(1) * v * (1-v)];
end

