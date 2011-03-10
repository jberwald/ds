function tree = flagboxes(tree,n)

  if nargin < 2
	boxes = tree.boxes(-1);
	n = size(boxes,2);
  end

  w = repmat('0',1,n);

  for b = 1:n
	v = w;
	v(b) = '1';
	tree.set_flags(v,b,-1);
  end

