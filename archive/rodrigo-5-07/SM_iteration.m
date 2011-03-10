
function [x y] = SM_iteration(x0,y0,epsilon)

     y = y0 + (epsilon/(2*pi))*sin(2*pi*x0);
     x = x0 + y;

end
