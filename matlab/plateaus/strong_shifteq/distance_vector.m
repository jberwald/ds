function v = distance_vector(D,comps)

  n = length(comps);
  d = repmat(0,1,n*(n-1));

  for i = 1 : n
	for j = i+1 : n
	  d(sub2ind([n n],i,j)) = component_distance(D,comps,i,j);
	end
  end

  [x v] = sort(d);						% order the pairs by distance


function d = component_distance(D,comps,i,j)
  D2 = D(comps{i},comps{j});
  d = min(D2(:));  % mean? med? other stat?
