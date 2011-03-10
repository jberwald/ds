width = 0.005;
x0 = 0.845;
xn = 0.800;
for x = x0:-width:xn
  mapstr = sprintf('std_0p%i',ceil(x*1000))
  map = get_map('std',5,'params',infsup(x,x+width));
  [map results] = homoclinic_driver(map,12);
  save_map_special(map,mapstr);
  save([mapstr '.mat'],'results');
end
