
function y = check_hyperbolic(n,x,epsilon)

%
% function check_hyperbolic(n,x)
%
% This function checks to see if a periodic orbit of the standard map of
% period n is hyperbolic or not at the point x. Outputs 1 if it is, 0 if 
% it is not.

Df = [1+epsilon*cos(2*pi*x) 1; epsilon*cos(2*pi*x) 1];
A = (Df)^n;

tr = trace(A);

dis = tr*tr - 4;

if dis < 0
  y = 0;
else
  y = 1;
end
