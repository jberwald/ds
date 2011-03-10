function P = rigorous_matrix(tree,depth,interval_map)
% function P = rigorous_matrix(tree,depth,interval_map)
% function P = rigorous_matrix(map [,depth])
%   assumes imap maps row vectors

if (nargin < 3)
  map = tree;
  tree = map.tree;
  if (nargin == 1)
	depth = map.tree.depth;
  end % otherwise depth is given
  interval_map = map.map;
end

n = tree.count(depth);					% Number boxes
d = tree.dim;
boxes = tree.boxes(depth);
P = sparse(n,n);     					% Initialize transition matrix

for i = 1 : n
  [center radius] = map_box_int(boxes(:,i),interval_map);

  img = [];
  for c = 1 : size(center, 2)
	img = union(img, tree.search_box(center(:,c), radius(:,c)) );
  end

  if (~all(img))
	img
  end

  P(img,i) = 1;
end
