function A = torus_adj_matrix(tree, depth, S)
  
  k = 2^(depth/2);  
  q = 2^(-depth/2);

  left_edges = zeros(2,k);
  right_edges = zeros(2,k);

  left_edges(1,:) = q/2;
  left_edges(2,:) = (1:k)*q - q/2;

  right_edges(1,:) = 1 - left_edges(1,:);
  right_edges(2,:) = left_edges(2,:);

  upper_edges = right_edges([2 1],:);
  lower_edges = left_edges([2 1],:);
  
  left_edge = tree.search(left_edges,depth);
  right_edge = tree.search(right_edges,depth);
  upper_edge = tree.search(upper_edges, depth);
  lower_edge = tree.search(lower_edges, depth);
  
  A = tree_adj_matrix(tree, depth, S);
  
  for i = 1 : k
    
	if (upper_edge(i) > 0 && lower_edge(i) > 0)
	  A(upper_edge(i),lower_edge(i)) = 1;
	  A(lower_edge(i),upper_edge(i)) = 1;
	end
    
	if (right_edge(i) > 0 && left_edge(i) > 0)
	  A(right_edge(i),left_edge(i)) = 1;
	  A(left_edge(i), right_edge(i)) = 1;
    end

  end
  
  if (upper_edge(k) > 0 && lower_edge(1) > 0)
	A(lower_edge(1),upper_edge(k)) = 1;
	A(upper_edge(k),lower_edge(1)) = 1;
  end

  if (right_edge(k) > 0 && left_edge(1) > 0)
	A(left_edge(1),right_edge(k)) = 1;
	A(right_edge(k),left_edge(1)) = 1;
  end

