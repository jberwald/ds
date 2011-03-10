function mapobj = get_map_special(mapname,nickname)
% mapobj = get_map_special(mapname,nickname)
% Retrieves a map that was saved using save_map_special
%
% map = get_map_special('henon','cool_ip'); 

  mapobj = eval(sprintf('init_%s',mapname));
  mapobj.name = mapname;

  mapobj.prefix = [data_dir() '/' nickname];
  
  treename = sprintf('%s.tree', mapobj.prefix);
  dataname = sprintf('%s.mat', mapobj.prefix);
  tree = Tree(treename);
  load(dataname);

  mapobj.tree = tree;
  mapobj.P = P;
  mapobj.Adj = Adj;
  mapobj.I = I;
  mapobj.params = params;
  mapobj.center = center;
  mapobj.radius = radius;
  mapobj.depth = depth;

  mapobj.map = mapobj.mapfunc(params);

end
