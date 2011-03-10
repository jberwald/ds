function save_map_special(map,nickname)
% function save_map_special(map,nickname)
% saves the map for retrieval with get_map_special

  dirs = strfind(map.prefix,'/');
  map.prefix = [map.prefix(1:dirs(end)) nickname];

  save_map(map);

  dataname = sprintf('%s.mat',map.prefix);
  center = map.center;
  radius = map.radius;
  params = map.params;
  depth = map.depth;
  save(dataname,'-append','center','radius','params','depth');
end
