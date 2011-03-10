function Imgs = interval_images(map,boxes,S,Imgs)
% function Imgs = interval_images(map,boxes,S,Imgs)
  
  if (nargin < 3)
	S = 1 : size(boxes,2);
  end
  
  if (nargin < 4)
	Imgs = {};
  end

  for i = S
	[center radius] = map_box_int(boxes(:,i), map);
	Imgs(i,:) = {center, radius};		% add new images
  end

end
