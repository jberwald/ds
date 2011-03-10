function h=showset(map, S, col)
% function h=showset(map, S, col)

if nargin < 3
  col = 'g';
end

boxes = map.tree.boxes(-1);

if nargin < 2
  S = 1:size(boxes,2);
end

if (map.tree.dim == 2)
  if (map.tree.depth <= 14)
    h = show2(boxes(:,S)',col);
  else
    h = showraf(boxes(:,S)',col);
  end  
elseif (map.tree.dim == 3)
  if (map.tree.depth <= 18)
    h = show3(boxes(:,S)',col);
  else
    h = show3(boxes(:,S)',col,3,1:3,col);
  end  
end
    
