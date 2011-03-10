function [map S] = insert_onebox(map,boxes,S,flag)	% to be optimized...
% function insert_onebox(map,boxes,S,flag)
% function insert_onebox(map,boxes,S)
% function insert_onebox(map,boxes)
% function insert_onebox(map)
  if (nargin < 2)
	boxes = map.tree.boxes(-1);
  end

  if (nargin < 3)
	S = 1 : size(boxes,2);
  end

  if (nargin < 4)
	flag = 2;
  end

  boxes = scale_boxes(boxes,1.1);

  d = map.tree.dim;
  
  if (strcmp(map.space,'torus'))		% handle the torus case separately
	for i = S(:)'							% row vector
	  box = boxes(:, i);
	  v = box2intval(box(1:d),box(d+1:2*d));  % convert to intervals
	  I = wrap_box(v,[1 1]);			% the whole point: keep track of the topology
	  for k = 1 : size(I,1)				% number of boxes returned
		[ctr rad] = intval2box(I(k,:)); % convert back to a box
		map.tree.insert_box(ctr, rad, map.tree.depth, flag);
	  end
	  
	end
  else
	for i = S(:)'							% row vector
	  c_i = boxes(1:d, i);
	  r_i = boxes((d+1):2*d, i);
	  map.tree.insert_box(c_i, r_i, map.tree.depth, flag);
	end
  end

  if (nargout >= 2)
	map.tree.count(-1);
	S = search_boxes_set(map.tree,boxes);
  end
end
