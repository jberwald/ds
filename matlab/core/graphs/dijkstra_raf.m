function p = dijkstra_raf(A, s, t)

  p = [];

  [distances discover_times pred] = bfs(A', s);
  n = distances(t) + 1;

  if (n>0)
	p = zeros(1,n);
	p(n) = t;
	
	for i = n-1:-1:1
	  p(i) = pred(p(i+1));
	end
  end
