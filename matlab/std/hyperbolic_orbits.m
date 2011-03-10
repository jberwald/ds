function PPhyp = hyperbolic_orbits(map,PP)
% function PPhyp = hyperbolic_orbits(map,PP)
% checks each orbit in PP to see if it is hyperbolic, using
% standard-map-specific code
  
  f = @(i) check_hyperbolic_map(PP{i,2},PP{i,1},map);
  v = arrayfun(f,1:size(PP,1))==1;
  PPhyp = PP(v,:);
    
