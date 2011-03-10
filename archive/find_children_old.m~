function seen=find_children(A,S)
% input: graph (sparse matrix) A and vertices S
% ouput: all vertices reachable from S in A

A = A';							% dfs assumes A_ij = edge from i to j
seen = zeros(size(A,1),1);

for v=S
  if (~seen(v))
    [d dt ft pred] = dfs(A,v);
	if (~A(v,v))
	  d(v) = -1;				% only have positive distance if v->v
	end
    seen_now = find(d>=0);
    A(seen_now,seen_now) = 0;
    seen(seen_now) = 1;
  end
end


