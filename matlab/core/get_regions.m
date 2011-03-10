function comps = get_regions(S,Adj)
% function R = get_regions(S,Adj)
% input: a set of boxes S and the adjacency matrix Adj
% output: a cell array of connected components of S

  if (isempty(S) || isempty(Adj))
	comps = {};
	return
  end

  Adj = sparse(Adj(S,S));
  [comp_inds comps P] = components_raf(Adj); % the scc's of Adj

  for i=1:length(comps)
	comps{i} = S(comps{i});				% original numbering
  end
