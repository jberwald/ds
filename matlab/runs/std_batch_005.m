opts = struct('per2',1);

width = 0.005;
for eps = 1.8 : width : (2.0 - width)
  params = infsup(eps,eps+width);
  fname = sprintf('std_1p%d_005',floor(1000*(eps-1)))
  depth = 9;
  map = get_map('std',6,'params',params);
  [map dat] = homoclinic_driver(map,depth,opts);
  save_map_special(map,sprintf('%s_d%i',fname,depth));
  save([fname '.mat'],'dat')
end
