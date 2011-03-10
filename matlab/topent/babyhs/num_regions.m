function n = num_regions(S,Adj)
% function n = num_regions(S,Adj)
% input: a set of boxes S and the adjacency matrix Adj
% output: the number of connected components of S
  
  Adj = Adj(S,S);
  [comp_inds comps P] = components_raf(Adj); % the scc's of Adj
  n = length(comps);
