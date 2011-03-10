
function v = henon_zin_image(x,y,a,b)

% This computes the interval image of the Henon map
% H(x,y) = (a - x^2 + b*y, x) where x, y, a, b are intervals.

v(1) = (a - x * x + b * y);

v(2) = x;
