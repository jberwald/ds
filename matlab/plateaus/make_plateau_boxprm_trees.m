function make_plateau_boxprm_trees(plats,depths,dlen,dvec,platfile)
% make_plateau_boxprm_trees(plats,depths,dlen)
% dlen = # of boxes between depths
% dvec = which box sizes (between 1 and dlen) to compute

  if (nargin < 4)
	dvec = 1:dlen;
  end
  if (nargin < 5)
	platfile = 'plateaus/repdat.mat';
  end

  load(platfile)						% get 'reps'

  mapname = 'henon';
  
  for p = 1 : length(plats)

	params = reps(plats(p),:);

	for d = dvec

	  box = [2 2] + [2 2]*(d-1)/dlen;

	  start_d = highest_depth_done(mapname, depths, params, box);

	  [tree P Adj] = get_map_old('henon', depths(start_d), ...
									  'params', params, ...
									  'box', box);

	  for depth = start_d+1:length(depths)

		[tree P Adj] = get_map_old('henon', depths(depth), ...
										'params', params, ...
										'box', box,  tree);

		fprintf('tree and matrices done for plateau %i, depth %i.%i\n', ...
				plats(p), depths(depth), d);
	  end

	end
  end
end

function i = highest_depth_done(mapname,depths,params,box)

  param_str = sprintf('_%3.6f',[inf(params);sup(params)]);
  box_str = sprintf('_%3.6f',box);

  i = 1;
  for i = 1 : length(depths)
	name_i = sprintf('%s/%s_boxprm_%d%s_%s.tree', ...
					 data_dir(), mapname, depths(i), box_str, param_str);
	[s r] = unix(['ls ' name_i]);
	if (s ~= 0)							% file not found
	  i = max(1,i-1);					% last one was there
	  return
	end
  end
end

