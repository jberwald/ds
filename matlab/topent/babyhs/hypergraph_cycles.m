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

  n = max(max(E));

  C = [];
  comb = 1:k+1;							% assuming k < n
  done = 0;

  while (~done)	
	if (check_cycle(E,comb))
	  C(end+1,:) = comb;
	end
	[comb done] = comb_next(n,k+1,comb,done);
  end

end


function b = check_cycle(E,v)
  for i = v
	if (~ismember(setdiff(v,i),E,'rows'))
	  b = false;
	  return
	end
  end
  b = true;
end


function S = union_hyperedges(E,v)
  S = [];
  for i=v
	S = union(S,E(i,:));
  end
end  
