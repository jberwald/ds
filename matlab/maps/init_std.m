function mapobj = init_std

  mapobj = struct;
  mapobj.params = 0.98;
  mapobj.mapfunc = @(params) (@(v) the_map(v(1),v(2),params));
  mapobj.invfunc = @(params) (@(v) inv_map(v(1),v(2),params));
  mapobj.boxfunc = @(params) get_box(params);
  mapobj.space = 'torus';

end

function [center radius] = get_box(params)
  center = [0.5 0.5];
  radius = [0.5 0.5];
end

function V = the_map(x,y,e)

  Y = y + (e/(2*pi))*sin(2*pi*x);
  X = x + Y;

  X = wrap_interval(X,1);
  Y = wrap_interval(Y,1);

  V = glue_together(X,Y);

end

function V = inv_map(x,y,e)
% This computes the interval image of the inverse of the standard map
% S(x,y) = (x + y + (e/2*pi)*sin(2*pi*x), y + (e/2*pi)*sin(2*pi*x)) 
% where x and y are intervals and 0 < e < 2 or so.

  X = x - y;
  Y = y - (e/(2*pi))*sin(2*pi*(x-y));

  V = wrap_box([X Y],[1 1]);

end

