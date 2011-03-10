
function [x y] = SM_iteration_period2(x0,y0,epsilon)

     PI = 3.1415926535;

%x = x0 + 2*y0 + (epsilon/pi)*sin(2*pi*x0) + (epsilon/(2*pi))*sin(2*pi*(x0+y0+(epsilon/(2*pi))*sin(2*pi*x0)));
%y = y0 + (epsilon/(2*pi))*sin(2*pi*x0) + (epsilon/(2*pi))*sin(2*pi*(x0+y0+(epsilon/(2*pi))*sin(2*pi*x0)));

xx = x0 + y0 + (epsilon/(2*pi))*sin(2*PI*x0);
yy = y0 + (epsilon/(2*pi))*sin(2*PI*x0);

x = xx + yy + (epsilon/(2*pi))*sin(2*PI*xx);
y = yy + (epsilon/(2*pi))*sin(2*PI*xx);

end
