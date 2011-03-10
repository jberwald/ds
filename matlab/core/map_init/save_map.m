function save_map(map)
% function save_map(map)
% saves the map for retrieval with get_map

  treename = sprintf('%s.tree',map.prefix);
  dataname = sprintf('%s.mat',map.prefix);

  tree = map.tree;
  P = map.P;
  Adj = map.Adj;
  I = map.I;

  tree.save(treename);					% save the data
  save(dataname,'P','Adj','I');

end
