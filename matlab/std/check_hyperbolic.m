
function y = check_hyperbolic(n,x,epsilon)

%
% function check_hyperbolic(n,x)
%
% This function checks to see if a periodic orbit of the standard map of
% period n is hyperbolic or not at the point x = (x(1),x(2)). Outputs 1 
% if it is, 0 if it is not.
%

xOrbit = x(1);
yOrbit = x(2);

cocycle = eye(2);

for i = 1 : n

  cocycle = [1+epsilon*cos(2*pi*xOrbit) 1; epsilon*cos(2*pi*xOrbit) 1]*cocycle;

  oldX = xOrbit;
  oldY = yOrbit;

  xOrbit = oldX + oldY + epsilon*sin(2*pi*oldX)/(2*pi);
  yOrbit = + oldY + epsilon*sin(2*pi*oldX)/(2*pi);

end

tr = trace(cocycle);

dis = tr*tr - 4;

if dis > 0
  y = 1;
else
  y = 0;
end
