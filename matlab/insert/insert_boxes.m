function insert_boxes(tree,boxes,depth)
% function insert_boxes(tree,boxes,depth)

  d = tree.dim;

  for i = 1 : size(boxes,2)

	tree.insert_box(boxes(1:d, i), boxes((d+1):2*d, i), depth);

  end

end
