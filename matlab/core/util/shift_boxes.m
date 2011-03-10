function boxes = shift_boxes(boxes, v, w)
% function boxes = shift_boxes(boxes, v, w)
% v is either a scalar or a vector of length dim
% w is a modulus

  d = (size(boxes,1)-2)/2;

  if (length(v) == 1)
	boxes(1:d, :) = boxes(1:d, :) + v;
  else
	for i = 1 : d
	  boxes(i,:) = boxes(i,:) + v(i);
	end
  end

  if nargin >= 3
	if (length(w) == 1)
	  boxes(1:d,:) = mod(boxes(1:d,:),w);
	else
	  for i = 1 : d
		boxes(i,:) = mod(boxes(i,w(i)));
	  end
	end
  end
	
