function standard_map(e,k,n,col)
% function standard_map(e,k,n,col)
% Plots trajectories of th standard map
%
% Perturbation e, k different initial conditions, and n iterations of
% each orbit. cool stuff happens when 0<e. Really cool stuff happens when
% .8 < e

if nargin < 4
  col = 'k';
end

X = random(k,2);

orbits = {};

for i = 1 : size(X,1)
    orbits{i}(1,1) = mod(X(i,1),1);
    orbits{i}(1,2) = mod(X(i,2),1);
    for k = 1: n
        orbits{i}(k+1,1) = mod(orbits{i}(k,1) + orbits{i}(k,2) + (e/(2*pi))*sin(2*pi*orbits{i}(k,1)),1);  % mod 1!
        orbits{i}(k+1,2) = mod(orbits{i}(k,2) + (e/(2*pi))*sin(2*pi*orbits{i}(k,1)),1);
    end
end

hold on % to me, don't you ever let me go
for i = 1 : size(X,1)
    for k = 1 : size(orbits{i},1)
        plot(orbits{i}(k,1),orbits{i}(k,2),'color',col)
    end
end
