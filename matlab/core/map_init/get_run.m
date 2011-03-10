function [mapobj dat] = get_run(mapname,nickname)
% [mapobj dat] = get_run(mapname,nickname)
% Retrieves a run that was saved using save_run
%
% [map dat] = get_run('henon','cool_ip'); 

  mapobj = get_map_special(mapname,[nickname '-run-map']);
  load([data_dir() '/' nickname '-run-dat.mat']);

end
