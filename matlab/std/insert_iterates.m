function [tree points] = insert_iterates(tree,map,point,n,depth)
  points = zeros(tree.dim,n+1);
  points(:,1) = point;
  for i=1:n
	points(:,i+1) = map(points(:,i));
  end
  tree.insert(points, depth);
