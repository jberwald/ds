
function map = std_inverse(params)
% This computes the interval image of the inverse of the standard map
% S(x,y) = (x + y + (e/2*pi)*sin(2*pi*x), y + (e/2*pi)*sin(2*pi*x)) 
% where x and y are intervals and 0 < e < 2 or so.

  map = @(v) inv_map(v(1),v(2),params);

end


function V = inv_map(x,y,e)

  X = x - y;
  Y = y - (e/(2*pi))*sin(2*pi*(x-y));

  V = wrap_box([X Y],[1 1]);

end
