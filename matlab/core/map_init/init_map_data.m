function mapobj = init_map_data(mapobj)

  mapobj = update_prefix(mapobj);

  treename = sprintf('%s.tree', mapobj.prefix);
  dataname = sprintf('%s.mat', mapobj.prefix);

  % check whether the files exist... 
  [s r] = unix(sprintf('ls %s %s',treename,dataname));
  if (s == 0)							% success
	tree = Tree(treename);
	load(dataname);
	mapobj.tree = tree;
	mapobj.P = P;
	mapobj.Adj = Adj;
	mapobj.I = I;
  else
	mapobj.tree = Tree(mapobj.center, mapobj.radius);
    if (mapobj.depth > 0)
      mapobj = mistpuff(mapobj, mapobj.depth);
    else
      mapobj.P = sparse(1);
      mapobj.Adj = sparse(1);
      mapobj.I = [1];
    end
  end

  if (s ~= 0) % just computed the tree, so save it
	save_map(mapobj);
  end

end
