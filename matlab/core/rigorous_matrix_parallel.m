function P = rigorous_matrix_parallel(map);
% function P = rigorous_matrix(map)
%   assumes imap maps row vectors

depth = -1;
n = map.tree.count(depth);					% Number boxes
d = map.tree.dim;
boxes = map.tree.boxes(depth);
P = sparse(n,n);     					% Initialize transition matrix

k = map.slices;
func = map.parmapfunc(map.params);

ctr = boxes(1:d,:);
rad = boxes(d+1:2*d,:);
I = infsup(ctr-rad, ctr+rad);
V = slice_intervals(I,k)';              % need row vectors
W = func(V);                            % row vectors

for i = 1 : n

  img = [];
  for s = 1 : k^d                       % this range corresponds to i
    x = (i-1)*(k^d) + s;
    [center radius] = intval2box(W(:,x))
	img = union(img, map.tree.search_box(center, radius));
  end

  if (~all(img))
	img
  end

  P(img,i) = 1;
end
