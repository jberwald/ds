
function map = std_map(params)
% This computes the interval image of the standard map
% S(x,y) = (x + y + (e/2*pi)*sin(2*pi*x), y + (e/2*pi)*sin(2*pi*x)) 
% where x and y are intervals and 0 < e < 2 or so.

  map = @(v) the_map(v(1),v(2),params);

end


function V = the_map(x,y,e)

  X = x + y + (e/(2*pi))*sin(2*pi*x);
  Y = y + (e/(2*pi))*sin(2*pi*x);

  V = wrap_box([X Y],[1 1]);

end
