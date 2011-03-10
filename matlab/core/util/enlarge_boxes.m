function boxes = enlarge_boxes(boxes, v)
% function boxes = enlarge_boxes(boxes, v)
% adds v to the radius
% v is either a scalar or a vector of length dim

  d = (size(boxes,1)-2)/2;

  if (length(v) == 1)
	boxes((d+1):2*d, :) = boxes((d+1):2*d, :) + v;
  else
	for i = (d+1) : 2*d
	  boxes(i,:) = boxes(i,:) + v(i);
	end
  end
