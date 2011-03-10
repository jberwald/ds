function S = search_boxes(tree,old_boxes)
% function S = search_boxes(tree,old_boxes)
% input: tree and box matrix (old_boxes(:,i) is a box vector)
% output: the box numbers in tree that intersect boxes in old_boxes
% assumption: old boxes are at the same depth as the current tree

  d = tree.dim;
  n = size(old_boxes,2);
  S = zeros(1,n);
  for b = 1 : n
	box = old_boxes(:,b);
    center = box(1:d);
	new_boxes = tree.search(center, tree.depth);
	S(b) = new_boxes(1);
  end
end
