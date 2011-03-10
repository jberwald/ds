
function v = henon_int_image(x,y,a,b)

% This computes the interval image of the Henon map
% H(x,y) = (1-a*x^2 + y, b*x) where x and y are intervals.

v(1) = (1 - a * x * x + y);

v(2) = b * x;
