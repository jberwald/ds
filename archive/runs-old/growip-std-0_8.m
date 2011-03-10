map = get_std_map('stdmidgrowip',24,0.8);
load imgs-6-1
for i = 1 : 10
  [map Imgs] = grow_ip_insert(map,10,Imgs);
  save_map(map)
  save imgs-6-1 Imgs
end
