function make_trees_box(mapname,interval_map,depths,box0,boxn,n)
% make_trees_box(mapname,interval_map,depths,box0,boxn,n)

  if (n <= 1)							% just make one tree
	box_diff = 0;
	n = 0;
  else
	box_diff = (boxn - box0) / n;
  end

  for b = 0:n
	box = box0 + b * box_diff;
	tree = set_up_map_box(mapname, interval_map, depths(1), box);
  
	for depth = depths(2:end)
	  tree = set_up_map_box(mapname, interval_map, depth, box, tree);
	  fprintf('tree and matrices done at depth %d\n',depth);
	end

	fprintf('stage %d complete\n',b);
  end
