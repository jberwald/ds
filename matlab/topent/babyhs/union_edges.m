function S = union_edge(sets,edges)
  S = [];
  for e = 1 : size(edges,1)
	S = union(S,sets{edges(e,1),edges(e,2)});
  end
