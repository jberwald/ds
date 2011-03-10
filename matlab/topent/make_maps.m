function [tree P Adj I options prefix] = make_maps(mapname, depths, varargin)

  tree = get_map(mapname, depths(1), varargin{:});

  for d = depths(2:end)
	[tree P Adj I options prefix] = get_map(mapname, d, varargin{:}, tree);
  end

end
