function Z = growip_painter(stepnum,Z)
  map = Z{1};
  Imgs = Z{2};
  [map Imgs] = grow_ip_insert(map,stepnum,Imgs);
  Z = {map, Imgs};
 
%  map = get_std_map('stdmidgrowip',18,2);
%  load([map.prefix '-imgs.mat'])
%  makemovie('test',repmat(2,1,10),@growip_painter,{map,Imgs})
