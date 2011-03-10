function S = search_boxes_set(tree,old_boxes)
% function S = search_boxes(tree,old_boxes)
% input: tree and box matrix (old_boxes(:,i) is a box vector)
% output: any box numbers in tree that intersect boxes in old_boxes

  d = tree.dim;
  n = size(old_boxes,2);
  S = [];
  for b = 1 : n
	box = old_boxes(:,b);
    center = box(1:d);
    radius = box((d+1):(2*d));
	new_boxes = tree.search_box(center, radius, tree.depth);
	S = union(S,new_boxes);
  end
end
