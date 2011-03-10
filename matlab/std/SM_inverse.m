
function [x y] = SM_inverse(x0,y0,epsilon)

     x = x0 - y0;
     y = y0 - (epsilon/(2*pi))*sin(2*pi*(x0-y0));

end
