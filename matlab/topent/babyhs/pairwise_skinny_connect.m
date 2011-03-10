function S = pairwise_skinny_connect(C,v,P)

  S = cat(2,C{v});

  n = size(P,1);
  s = n+1;								% new vertices
  t = n+2;
  P(s,s) = 0;
  P(t,t) = 0;
 
  for j = 1 : length(v)
	for k = j+1 : length(v)

	  P(:,[s t]) = 0;					% zeros edges incident to s,t
	  P([s t],:) = 0;
	  P(C{v(j)},s) = 1;					% connect s to and from C_{v_j}
	  P(s,C{v(j)}) = 1;					
	  P(C{v(k)},t) = 1;					% connect t to and from C_{v_k}
	  P(t,C{v(k)}) = 1;					
	  P(C{v(j)},C{v(j)}) = 0;           % we want nontrivial connections
	  P(C{v(k)},C{v(k)}) = 0;

	  S_jk = dijkstra_raf(P,s,t);		% shortest path from C_{v_j} to C_{v_k}
	  S_kj = dijkstra_raf(P,t,s);		% shortest path from C_{v_k} to C_{v_j}

	  S = union(S,union(S_jk(2:end-1),S_kj(2:end-1))); % remove s,t first

	end
  end

end
