function make_trees_param(mapname,interval_function,depths,params)
% function make_trees(mapname,interval_function,depths,params)

  interval_map = @(v) interval_function(v(1),v(2),params(1),params(2));

  start_d = highest_depth_done(mapname,params,depths);
  [tree P Adj I] = set_up_map_prm(mapname, interval_map, depths(start_d), params);
  
  for depth = depths(start_d+1:end)
	[tree P Adj I] = set_up_map_prm(mapname, interval_map, depth, params, tree);
	disp(sprintf('tree and matrices done at depth %d',depth));
  end
end  

function i = highest_depth_done(mapname,params,depths)
  param_str = sprintf('_%3.6f',[inf(params);sup(params)]);
  i = 1;
  for i = 1 : length(depths)
	name_i = sprintf('%s/%s_params_%d%s.tree',data_dir(),mapname,depths(i),param_str);
	[s r] = unix(['ls ' name_i]);
	if (s ~= 0)							% file not found
	  i = max(1,i-1);					% last one was there
	  return
	end
  end
end

