
function [xi yi x_points y_points x_reverse y_reverse] = draw_stable_manifold(epsilon, n, p, iter)

% function draw_unstable_manifold(epsilon, n, p, iter)
%
% This function plots an approximation to the unstable manifold of the standard map.
% This is done by approximating the manifold at the origin by the unstable eigenvector
% of the linearization at the origin.
% epsilon - perturbation parameter
% n - number of points plotted
% p - precision. That is, to what scale do we shrink the unstable eigenvector (should be small)
% iter - number of iterations of linear segment

lambda_plus = calculate_lambda_plus(epsilon);
lambda_minus = calculate_lambda_minus(epsilon);

Eu = [(lambda_plus - 1) epsilon];
Es = [(lambda_minus - 1) epsilon];

x_points = 0 : (Eu(1)*p)/n : Eu(1)*p;
y_points = 0 : (Eu(2)*p)/n : Eu(2)*p;

x_reverse = zeros(n,1);
y_reverse = zeros(n,1);

for i = 1 : n

  for j = 1 : iter

    [x_points(i) y_points(i)] = SM_iteration(x_points(i), y_points(i), epsilon);

  end

  x_reverse(i) = -x_points(i) + 1;
  y_reverse(i) = -y_points(i) + 1;

end

plot(x_points([1:n]),y_points([1:n]),'b')
hold on
plot(x_reverse,y_reverse,'b')
hold on

% Now we try to find the primary point of intersection of the stable and unstable manifolds
% which should be somewhere in the line x = 0.5

  k = 1;

  while (x_points(k) < .5)

    k = k + 1;

  end

  xi = 0.5;
  yi = y_points(k);

  plot(x_points(k), y_points(k), '*g')
  hold on

  plot(x_reverse(k), y_reverse(k), '*g')
  hold on

% Now we try to draw the stable manifold from here to the fixed point

x_pointss = 0 : (Es(1)*p)/n : Es(1)*p;
y_pointss = 0 : (Es(2)*p)/n : Es(2)*p;

x_pointss = x_pointss + 1;

x_reverses = zeros(n,1);
y_reverses = zeros(n,1);

for i = 1 : n
  for j = 1 : (iter+1)

    [x_pointss(i) y_pointss(i)] = SM_inverse(x_pointss(i), y_pointss(i), epsilon);

  end

 x_reverses(i) = -x_pointss(i) + 1;
 y_reverses(i) = -y_pointss(i) + 1;

end

plot(x_pointss([1:(n-1)]),y_pointss([1:(n-1)]),'r')
hold on
plot(x_reverses([1:(n-1)]),y_reverses([1:(n-1)]),'r')
hold on

function lambda_plus = calculate_lambda_plus(epsilon) % Calculates the largest eigenvalue of the fixed point.
     
   lambda_plus = (2 + epsilon + sqrt( (2+epsilon)*(2+epsilon) - 4))/2;

end

function lambda_minus = calculate_lambda_minus(epsilon) % Calculates the largest eigenvalue of the fixed point.
     
   lambda_minus = (2 + epsilon - sqrt( (2+epsilon)*(2+epsilon) - 4))/2;

end

end
