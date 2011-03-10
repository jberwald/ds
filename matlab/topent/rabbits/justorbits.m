function sets = justorbits(map,k,variant,C)
% function sets = justorbits(map,k,variant,C)
% 
% a driver script with a bunch of (slightly confusing) variants:
% 0: computes the candidates, runs stronglyconnect with fat connections
% 1: computes the candidates, runs stronglyconnect with skinny connections
% 2: is given the orbits, runs stronglyconnect with skinny connections
% 3: is given the orbits, and just throws them together
    
  if nargin < 3
    variant = 0;
  end
  
  if variant == 0
    skinny = 0;
    C = periodic_candidates(map.P, k); % cell array
  elseif variant == 1
    skinny = 1;
    C = periodic_candidates(map.P, k); % cell array
  elseif variant == 2
    skinny = 1;
    C = C(1:k,1);              % just the first k orbits
  elseif variant == 3 || variant == 4
    C = C(1:k,1);              % just the first k orbits
    sets = {cat(2,C{:})};                   % all together now
    return
  end
  
  S = cat(2,C{:});                   % all together now
  sets = stronglyconnect(S,map,skinny);