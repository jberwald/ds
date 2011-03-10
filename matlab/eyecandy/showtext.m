function output = showtext(boxes,display_char,input)
% function output = showtext(boxes,display_char,input)
% assumes 2d
    
    box_size = boxes(3:4,1)'*2;

    % find the size of the region, and add some padding
    tree_botleft = [min(boxes(1,:)) min(boxes(2,:))] - box_size/2; % corner
    tree_topright = [max(boxes(1,:)) max(boxes(2,:))] + box_size/2; % corner
    tree_size = round((tree_topright - tree_botleft) ./ box_size) % size in "pixels"
    
	if (nargin > 2)
	  output = input;
	else
	  output = repmat('.',[tree_size(2),tree_size(1)]);
	end
    
	for box = boxes						% picks out columns
      % find the array entry for this box
      pos = round((box(1:2)'-box(3:4)'-tree_botleft) ./ box_size);
	  if (pos(1) > 0 && pos(1) <= size(output,1) && pos(2) > 0 && pos(2) <= size(output,2))
		output(tree_size(2)-pos(2),pos(1)+1) = display_char;		% color
	  end
    end
    
