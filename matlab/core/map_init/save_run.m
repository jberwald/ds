function save_run(map,dat,nickname)
% function save_run(map,dat,nickname)
% saves the map and run data for retrieval with get_run

  save_map_special(map,[nickname '-run-map'])
  save([data_dir() '/' nickname '-run-dat.mat'],'dat')
  
end
