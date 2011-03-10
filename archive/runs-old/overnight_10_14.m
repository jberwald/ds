
  params = [infsup(1.25,1.5) infsup(0.25, 0.375)];
  interval_map = @(v) henon_int_image(v(1),v(2),params(1),params(2));

make_trees_param('henon',interval_map,[14 16 18 20],params);
