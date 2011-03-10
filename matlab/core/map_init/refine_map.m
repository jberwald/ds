function mapobj = refine_map(mapobj, depth)
% function mapobj = refine_map(mapobj, new_depth)
% assumes mapobj is fully initialized

  for d = mapobj.depth+1 : depth
	mapobj = mistpuff(mapobj, d);
	mapobj = update_prefix(mapobj);
	save_map(mapobj);
  end
end
