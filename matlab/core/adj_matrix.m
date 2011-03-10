function A = adj_matrix(map,depth,S)

  if nargin < 2
    depth = map.tree.depth;
  end
  if nargin < 3
	S = 1 : map.tree.count(depth);
  end

  if (strcmp(map.space,'torus'))
    A = torus_adj_matrix(map.tree,depth,S);
    return
  else
    A = tree_adj_matrix(map.tree,depth,S);
  end
