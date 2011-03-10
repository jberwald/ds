function D = distance_matrix(R,boxes)

  f = @(r) [mean(boxes(1,r)); mean(boxes(2,r))];
  centers = cellfun(f,R,'uniformoutput',0);

  n = length(R);
  D = sparse(n,n);

  dfunc = @(v,w) 4*abs(v(1)-w(1)) + abs(v(2)-w(2));

  for i = 1 : n
	for j = i+1 : n
	  D(i,j) = dfunc(centers{i},centers{j});
	end
  end

