function A = tree_adj_matrix(tree,depth,S)
  
  d = tree.dim;
  n = tree.count(depth);
  boxes = tree.boxes(-1);
  A = sparse(n,n);			% creates an all-zero sparse matrix

  for i = S
    center = boxes(1:d,i);
    radius = boxes(d+1:2*d,i);

    adj = tree.search_box(center, radius*1.1, depth); % adjacent boxes
    A(adj,i) = 1;
  end
