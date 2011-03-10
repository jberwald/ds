function showimg(map,S,col)
% showimg(map,S,col)
% showimg(map,S) % default: green
% showimg(map) % whole map, green
    
  boxes = map.tree.boxes(-1);

  if nargin < 3
    col = 'g';
  end
  if nargin < 2
    S = 1:size(boxes,2);
  end
  
  Imgs = interval_images(map.map,boxes,S);
  Imgs = Imgs(S,:);

  b = [];
  for i = 1:size(Imgs,1)
    %    Imgs{i,:}
    z = zeros(size(Imgs{i,1},2),1);     % pad w/ 0's for flag + col
    b = [b; Imgs{i,1}' Imgs{i,2}' z z];
  end

  if (map.tree.dim == 2)
    if (map.tree.depth <= 14)
      show2(b,col);
    else
      showraf(b,col);
    end  
  elseif (map.tree.dim == 3)
    if (map.tree.depth <= 18)
      show3(b,col);
    else
      show3(b,col,3,1:3,col);
    end  
  end