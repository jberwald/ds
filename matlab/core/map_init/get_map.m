function mapobj = get_map(mapname, depth, varargin)
% function mapobj = get_map(mapname, depth, [optional args])
%
% Computes the desired map at the desired depth, or loads it if is already in
% the data directory.  In either case, the map will be saved in the data
% directory after get_map finishes.  Optionally, you can specify non-default
% parameters or a bounding box dilation (useful for continuously scaling
% resolution).  Some example calls:
%
% Henon with classical parameters and depth 7:
% >> map = get_map('henon',7)
% 
% Henon with box twice as big in both dimensions, and at non-classical
% parameters:
% >> map = get_map('henon',7,'box',[2 2],'params',[1.1,0.2])
% 

  init_func_name = sprintf('init_%s',mapname);
  mapobj = eval(init_func_name);

  fields = {'params','boxfunc','mapfunc','space'};
  undef = ~isfield(mapobj,fields);
  if any(undef)
	error(['the ' init_func_name ...
		   ' function must define the following fields:' ...
		   sprintf(' %s',fields{undef})])
  end

  dilation = 1;

  while (~isempty(varargin))
	args_eaten = 1;

	if (strfind(varargin{1}, 'params'))
	  mapobj.params = varargin{2};
	  args_eaten = 2;
	elseif (strfind(varargin{1}, 'box'))
	  dilation = varargin{2};
	  generate_box = 0;
	  args_eaten = 2;
	elseif (strfind(varargin{1}, 'dilate'))
	  dilation = varargin{2};
	  args_eaten = 2;
	end

	varargin(1:args_eaten) = [];
  end

  [c r] = mapobj.boxfunc(mapobj.params);
  mapobj.center = c;
  mapobj.radius = r .* dilation;

  mapobj.map = mapobj.mapfunc(mapobj.params);
  if isfield(mapobj,'invfunc')
    mapobj.inverse = mapobj.invfunc(mapobj.params);
  end
  mapobj.name = mapname;
  mapobj.depth = depth;

  mapobj = init_map_data(mapobj);

end
