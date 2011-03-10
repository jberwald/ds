
function [x y] = SM_inverse(x0,y0,epsilon)

     xx = x0 - y0;
     yy = y0 - (epsilon/(2*pi))*sin(2*pi*(x0-y0));

     x = xx - yy;
     y = yy - (epsilon/(2*pi))*sin(2*pi*(xx-yy));

end
