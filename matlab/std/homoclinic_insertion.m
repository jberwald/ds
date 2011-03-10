function [map Imgs] = homoclinic_insertion(map, depth, img_num)

  if (nargin < 3)
	img_num = 1;
  end

  S = homoclinic_set(map);

  for i = 1 : img_num
	S = union(S, mapimage(map.P, S));
  end

  % save boxes for the homoclinic connection and its images (B)
  boxes = map.tree.boxes(-1);
  B = boxes(:,S);

  % kill all boxes!
  map.tree.unset_flags('all',1);
  map.tree.remove(1);
  
  % insert the old boxes (B) at the new (lower) depth
  insert_boxes(map.tree, B, map.tree.dim * depth);
  insert_onebox(map.tree, B);

  disp('adding the tree image...')
  % get the new boxes, and add the image of the tree
  boxes = map.tree.boxes(-1);
  Imgs = interval_images(map.map,boxes);
  insert_image(map.tree, Imgs);

  % get the boxes again (adding more changed numbers)
  boxes = map.tree.boxes(-1);
  
  showraf(boxes','g','g');

  disp('computing the map...')
  map.P = rigorous_matrix(map);
  map.I = graph_mis(map.P);

  showraf(boxes(:,map.I)','b','b');

