function map = focm_get_ap_plat(plat, res)
  
  apreps = [4.538452 4.540894 4.580000 4.632324 4.678772 4.783752 4.860000 ...
          4.967896 5.148315 5.400000 5.590000 5.650000 5.683960 5.685974 5.693420 5.849976];

  fprintf('retrieving plateau %i at depth 14 (28) with resolution %i...\n',plat,res)
  
  box = 2.0 + (res-1)*(0.25);
  str = sprintf(['data/henon_boxprm_28_%1.6f_%1.6f__%1.6f_%1.6f_-1.000000_-' ...
                 '1.000000'],box,box,apreps(plat),apreps(plat));
  disp(str)
  map = get_map('henon2',1,'params',intval([apreps(plat) -1]));
  load([str '.mat'])
  map.P = P;
  map.Adj = Adj;
  map.I = I;
  map.tree = Tree([str '.tree']);
  map.center = map.tree.center;
  map.radius = map.tree.radius;
  map.depth = 14;
  map.space = 'Rn';

  map = update_prefix(map);

end