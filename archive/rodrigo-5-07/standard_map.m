
function standard_map(e,k,n)

% Standard map with perturbation e, k different initial conditions, and n iterations of
% each orbit. cool stuff happens when 0<e. Really cool stuff happens when
% .8 < e

PI = 3.1415926535;

X = random('normal',.2,.55,k,2);

orbits = {};

x = 0;
y = 0;

for i = 1 : size(X,1)
    
    orbits{i}(1,1) = mod(X(i,1),1);
    orbits{i}(1,2) = mod(X(i,2),1);
    
    for k = 1: n
        
        orbits{i}(k+1,1) = mod(orbits{i}(k,1) + orbits{i}(k,2) - (e/(2*PI))*sin(2*PI*orbits{i}(k,1)),1);  % mod 1!
        
        orbits{i}(k+1,2) = mod(orbits{i}(k,2) - (e/(2*PI))*sin(2*PI*orbits{i}(k,1)),1);
        
    end
    
end

colors = ['b' 'g' 'r' 'c' 'm' 'k' 'y'];

for i = 1 : size(X,1)
    
    for k = 1 : size(orbits{i},1)
        
        plot(orbits{i}(k,1),orbits{i}(k,2),colors(mod(i,7)+1))
    hold on
    end
    
end