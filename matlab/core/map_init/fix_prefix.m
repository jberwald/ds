function map = fix_prefix(map)

  map.prefix = gen_prefix(map.mapname, map.tree.depth, ...
						  map.tree.center, map.tree.radius, ...
						  map.params);

end
