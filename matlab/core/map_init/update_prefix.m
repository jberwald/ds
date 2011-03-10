function mapobj = update_prefix(mapobj)

  p = mapobj.params;
  if (strfind(class(p),'intval'))
	param_str = sprintf('_%3.6f', [inf(p);sup(p)]);
  else
	param_str = sprintf('_%3.6f', p);
  end

  center_str = sprintf('_%3.6f', mapobj.center);
  radius_str = sprintf('_%3.6f', mapobj.radius);

  fprintf('%s/%s_depth_%d_center%s_radius%s_params%s\n', ...
		  data_dir(), mapobj.name, mapobj.depth, ...
		  center_str, radius_str, param_str);

  mapobj.prefix = sprintf('%s/%s_depth_%d_center%s_radius%s_params%s', ...
						  data_dir(), mapobj.name, mapobj.depth, ...
						  center_str, radius_str, param_str);
