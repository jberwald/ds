function boxes = cub2box(tree,cubes)
% function boxes = cub2box(tree,cubes)
% input: the tree and a vector of cub coordinates
% output: a cell array of boxes that each cube hits
  
  k = size(cubes,2);
  boxes = cell(1,k);
  
  treeboxes = tree.boxes(-1);
  dim = (size(treeboxes,1)-2)/2;
  radius = treeboxes(dim+1 : 2*dim, 1);

  for i = 1:k
	center = cubes(:,i) .* radius * 2;
%	cube = cubes(:,i);
%	fprintf('(%d,%d) -> (%3.4f,%3.4f)\n',cube(1), cube(2), center(1), center(2))
%	show2([center; radius; 0; 0]', 'y');

	boxes{i} = tree.search_box(center,radius);
  end
  
