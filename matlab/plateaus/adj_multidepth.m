function A = adj_multidepth(tree)
  
  d = tree.dim;
  n = tree.count(-1);
  A = sparse(n,n);			% creates an all-zero sparse matrix

  boxes = tree.boxes(-1);
  minradius = min(boxes(d+1:2*d,:)')';		% smallest radius
  
  for b = 1:n
	box = boxes(:,b);
    center = box(1:d);
    radius = box(d+1:2*d) + minradius/10; % small bubble around the box

    adj = tree.search_box(center, radius, -1); % adjacent boxes
    A(adj,b) = 1;
  end
