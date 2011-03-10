
function [x1 y1 x2 y2 x_points y_points x_reverse y_reverse x_pointss y_pointss x_reverses y_reverses] = draw_invariant_manifolds(epsilon,starsp)
%
% function draw_invariant_manifolds(epsilon,starsp)
%
% This function plots an approximation to the unstable manifold of the standard map.
% This is done by approximating the manifold at the origin by the unstable eigenvector
% of the linearization at the origin.
% epsilon - perturbation parameter
%

  if nargin < 2
    starsp = 1;
  end
  
p = .005;
[n iter] = number_of_iterations(epsilon);
if epsilon < 0.6
  iter = iter + 2;                      % raf 2/13/2010
end

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

  x1 = 0.5;
  y1 = y_points(k);

  if starsp
    plot(x_points(k), y_points(k), '*g')
    hold on
    
    plot(x_reverse(k), y_reverse(k), '*g')
    hold on
  end

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

[x2 y2] = other_homoclinic(x1, y1, x_pointss, y_pointss,x_points, y_points, epsilon);

if starsp
  plot(x2, y2, '*g')
  hold on

  plot(1-x2, 1-y2, '*g')
  hold on
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
