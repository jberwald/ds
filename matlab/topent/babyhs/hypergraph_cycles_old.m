function C = hypergraph_cycles(E)
% find all (k+1)-cycles in the k-uniform hypergraph E  

  m = size(E,1);						% number of hyperedges
  k = size(E,2);

  if (m < k+1)							% need at least k+1 edges...
	C = [];
	return
  end

  if (k==1)
	C = nchoosek(1:m,k+1);				% brute force: try all possible cycles
	return
  end

  C = [];
  comb = 1:k+1;
  done = 0;

  while (~done)	
	cycle = union_hyperedges(E,comb);	% a possible cycle
	if (length(cycle) == k+1) % cycle iff union(k+1 disjoint k-sets) == (k+1)-set
	  comb
	  cycle
	  C(end+1,:) = cycle;
	end
	[comb done] = comb_next(m,k+1,comb,done);
  end

end

function S = union_hyperedges(E,v)
  S = [];
  for i=v
	S = union(S,E(i,:));
  end
end  
