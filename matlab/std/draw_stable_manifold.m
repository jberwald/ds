function [xi yi x_points y_points x_reverse y_reverse x_pointss y_pointss ...
		  x_reverses y_reverses] = draw_stable_manifold(epsilon, n, p, iter)

% function draw_unstable_manifold(epsilon, n, p, iter)
%
% This function plots an approximation to the unstable manifold of the standard map.
% This is done by approximating the manifold at the origin by the unstable eigenvector
% of the linearization at the origin.
% epsilon - perturbation parameter
% n - number of points plotted
% p - precision. That is, to what scale do we shrink the unstable eigenvector (should be small)
% iter - number of iterations of linear segment

[xi yi x_points y_points x_reverse y_reverse x_pointss y_pointss x_reverses ...
 y_reverses] = find_stable_manifold(epsilon, n, p, iter);

plot(x_points([1:n]),y_points([1:n]),'b')
hold on
plot(x_reverse,y_reverse,'b')
hold on

k = 1;
while (x_points(k) < .5)
  k = k + 1;
end

plot(x_points(k), y_points(k), '*g')
hold on
plot(x_reverse(k), y_reverse(k), '*g')
hold on

plot(x_pointss([1:(n-1)]),y_pointss([1:(n-1)]),'r')
hold on
plot(x_reverses([1:(n-1)]),y_reverses([1:(n-1)]),'r')
hold on
