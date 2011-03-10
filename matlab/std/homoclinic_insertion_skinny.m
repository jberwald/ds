function [map C] = homoclinic_insertion_skinny(map, depth, opts)

  if isintval(map.params)
	epsilon = (inf(map.params) + sup(map.params)) / 2;
  else
	epsilon = map.params;
  end

  % get the skeleton that we want to find at a high depth
  C = homoclinic_points(epsilon, depth, opts);

  map = insert_connections(map, C, depth, opts);
