function [tree points] = insert_iterates_smart(tree,map,point,n,depth,target,sensitivity)
  points = zeros(tree.dim,n+1);
  points(:,1) = point;
  for i=1:n
	points(:,i+1) = map(points(:,i));
	dist = norm(points(:,i+1)-target,2)
	if dist < sensitivity
	  disp('found the target')
	  points = points(:,1:i+1);
	  break
	end
  end
  tree.insert(points, depth);

