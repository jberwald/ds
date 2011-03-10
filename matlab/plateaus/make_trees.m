function make_trees(mapname,interval_map,depths)
% function make_trees(mapname,interval_map,depths)

  [tree P Adj] = set_up_map_int(mapname, interval_map, depths(1));
  
  for depth = depths(2:end)
	[tree P Adj] = set_up_map_int(mapname, interval_map, depth, tree);
	disp(sprintf('tree and matrices done at depth %d',depth));
  end
