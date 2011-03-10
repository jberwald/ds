function [map data1 data2] = refine_ip(map,X,A,I)
  old_boxes = map.tree.boxes(-1);
  
  map.tree.unset_flags('all',1);
  n = size(map.P,1);
  
  S = mapimage(map.P,X);
  S_str = sprintf('%1d', flags(S,n)); % string of '0's and '1's
  map.tree.set_flags(S_str, 1); % sets the 1 flag for all boxes in S
  map.tree.remove(1); % removes boxes w/ flags != 1, i.e. the boxes not in S
  
  for d=1:map.tree.dim
	map.tree.set_flags('all', 8);
	map.tree.subdivide;
  end

  map.P = rigorous_matrix(map.tree,map.tree.depth,map.map);  
  map.Adj = adj_matrix(map.tree,map.tree.depth);

  I_old = search_boxes(map.tree,old_boxes(:,I)); % new numbers for I

  data1 = compute_symbolics(I_old,map,{'nogrowiso'});
  data2 = compute_symbolics(I_old,map);

end
