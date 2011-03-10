function prefix = gen_prefix(mapname, depth, center, radius, params)

  if (strfind(class(params),'intval'))
	param_str = sprintf('_%3.6f',[inf(params);sup(params)]);
  else
	param_str = sprintf('_%3.6f',params);
  end

  center_str = sprintf('_%3.6f',center);
  radius_str = sprintf('_%3.6f',radius);
  prefix = sprintf('%s/%s_depth_%d_center%s_radius%s_params%s', ...
				   data_dir(), mapname, depth, center_str, radius_str, param_str);
