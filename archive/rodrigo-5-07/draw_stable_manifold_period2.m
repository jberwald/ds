
function [xi yi x_points y_points x_reverse y_reverse] = draw_stable_manifold_period2(epsilon, n, p, iter)

% function draw_unstable_manifold_period2(epsilon, n, p, iter)
%
% This function plots an approximation to the invariant manifolds associated to the 
% hyperbolic period 2 orbit of the standard map.
% This is done by approximating the manifold at the period 2 point by the unstable eigenvector
% of the linearization at this point of the second iterate of the map.
% epsilon - perturbation parameter
% n - number of points plotted
% p - precision. That is, to what scale do we shrink the unstable eigenvector (should be small)
% iter - number of iterations of linear segment

W = period_2(epsilon);

Df = [1+epsilon*cos(2*pi*W(1,1)) 1; epsilon*cos(2*pi*W(1,1)) 1];
Df2 = Df*Df;

tr = trace(Df2);
determ = det(Df2);

lambda_plus =  (-tr + sqrt(tr*tr - 4 * determ))/2;
lambda_minus =  (-tr - sqrt(tr*tr - 4 * determ))/2;

lambda_big = max(abs(lambda_plus), abs(lambda_minus));
lambda_small = min(abs(lambda_plus), abs(lambda_minus));

Eu = [-((lambda_big-1-epsilon*cos(2*pi*W(1,1)))/((2+epsilon*cos(2*pi*W(1,1)))*epsilon*cos(2*pi*W(1,1)))) -1];
Es = [((lambda_small-1-epsilon*cos(2*pi*W(1,1)))/((2+epsilon*cos(2*pi*W(1,1)))*epsilon*cos(2*pi*W(1,1)))) 1];

x_points1 = 0 : (Eu(1)*p)/n : Eu(1)*p;
y_points1 = 0 : (Eu(2)*p)/n : Eu(2)*p;

Eu = [((lambda_big-1-epsilon*cos(2*pi*W(1,1)))/((2+epsilon*cos(2*pi*W(1,1)))*epsilon*cos(2*pi*W(1,1)))) 1];

x_points2 = 0 : (Eu(1)*p)/n : Eu(1)*p;
y_points2 = 0 : (Eu(2)*p)/n : Eu(2)*p;

x_points1 = x_points1 + W(1,1);
y_points1 = y_points1 + W(2,1);

x_points2 = x_points2 + W(1,1);
y_points2 = y_points2 + W(2,1);

x_other1 = [];
y_other1 = [];

x_other2 = [];
y_other2 = [];

for i = 1 : n

  for j = 1 : iter

    [x_points1(i) y_points1(i)] = SM_iteration_period2(x_points1(i), y_points1(i), epsilon);
    [x_points2(i) y_points2(i)] = SM_iteration_period2(x_points2(i), y_points2(i), epsilon);
%    [x_points(i) y_points(i)] = [mod(x_points(i),1) mod(y_points(i),1)];

  end

  x_points1(i) = x_points1(i) - iter;
  x_points2(i) = x_points2(i) - iter;
  [x_other1(i) y_other1(i)] = SM_iteration(x_points1(i),y_points1(i),epsilon);
  [x_other2(i) y_other2(i)] = SM_iteration(x_points2(i),y_points2(i),epsilon);
 % [x_other(i) y_other(i)] = [mod(x_other(i),1) mod(y_other(i),1)];

end

plot(x_points1([1:n-2]),y_points1([1:n-2]),'g')
hold on
plot(x_other1([1:n-2]),y_other1([1:n-2]),'g')
hold on
plot(x_points2([1:n-2]),y_points2([1:n-2]),'g')
hold on
plot(x_other2([1:n-2]),y_other2([1:n-2]),'g')
hold on

% Now we try to draw the stable manifold 

x_pointss1 = 0 : (Es(1)*p)/n : Es(1)*p;
y_pointss1 = 0 : (Es(2)*p)/n : Es(2)*p;

Es = [-((lambda_small-1-epsilon*cos(2*pi*W(1,1)))/((2+epsilon*cos(2*pi*W(1,1)))*epsilon*cos(2*pi*W(1,1)))) -1];

x_pointss2 = 0 : (Es(1)*p)/n : Es(1)*p;
y_pointss2 = 0 : (Es(2)*p)/n : Es(2)*p;

x_pointss1 = x_pointss1 + W(1,1);
y_pointss1 = y_pointss1 + W(2,1);

x_pointss2 = x_pointss2 + W(1,1);
y_pointss2 = y_pointss2 + W(2,1);

x_others1 = [];
y_others1 = [];

x_others2 = [];
y_others2 = [];

for i = 1 : n

  for j = 1 : iter

    [x_pointss1(i) y_pointss1(i)] = SM_inverse_period2(x_pointss1(i), y_pointss1(i), epsilon);
    [x_pointss2(i) y_pointss2(i)] = SM_inverse_period2(x_pointss2(i), y_pointss2(i), epsilon);
%    [x_points(i) y_points(i)] = [mod(x_points(i),1) mod(y_points(i),1)];

  end

  x_pointss1(i) = x_pointss1(i) + iter;
  x_pointss2(i) = x_pointss2(i) + iter;
  [x_others1(i) y_others1(i)] = SM_iteration(x_pointss1(i),y_pointss1(i),epsilon);
  [x_others2(i) y_others2(i)] = SM_iteration(x_pointss2(i),y_pointss2(i),epsilon);
 % [x_other(i) y_other(i)] = [mod(x_other(i),1) mod(y_other(i),1)];

end

plot(x_pointss1([1:n-2]),y_pointss1([1:n-2]),'m')
hold on
plot(x_others1([1:n-2]),y_others1([1:n-2]),'m')
hold on
plot(x_pointss2([1:n-2]),y_pointss2([1:n-2]),'m')
hold on
plot(x_others2([1:n-2]),y_others2([1:n-2]),'m')
hold on
plot(W(1,1),W(2,1),'ko')
hold on
plot(W(1,2),W(2,2),'ko')
hold on

