
  interval_map = @(v) henon_int_image(v(1),v(2),1.4,0.3);
  [tree P Adj] = set_up_map_int('henon_1.425_0.425', interval_map, 24);

  depths = [26];
  for depth = depths
	set_up_map_int('henon_1.425_0.425', interval_map, depth, tree);
	disp(sprintf('tree and matrices done at depth %d',depth));
  end

  clear all

[R G M SM tree P Adj] = rodrigo_driver('henon_1.425_0.425',26,7);
save topdata/output_10_4.mat

