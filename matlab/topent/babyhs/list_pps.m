function PP = list_pps(max_period, map)
% function function PP = list_pps(max_period, map)
% inputs: max_period = maximum period to look for
%         P, Adj - the transition and adjacency matrix
% output: PP - cell array of periodic orbits

  candidates = periodic_candidates(map.P, max_period);
  PP = candidates_to_pps(candidates,map);
end  
