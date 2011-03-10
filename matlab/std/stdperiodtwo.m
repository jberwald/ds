function W = stdperiodtwo(epsilon)

%
% function stdperiodtwo(epsilon)
%
% This function returns the "main" unstable period 2 orbit
% of the standard map.

x1 = fzero(@(x) (4*x+(epsilon/(2*pi))*sin(2*pi*x)-1),.2);
y1 = -2*x1 - (epsilon/(2*pi))*sin(2*pi*x1) + 1;

y2 = y1 + (epsilon/(2*pi))*sin(2*pi*x1);
x2 = x1 + y2;

U = [x1;y1];
V = [x2;y2];
W = [U V];
