map = get_std_map('stdpregrowip',18,0.95);
[map Imgs P] = grow_ip_insert(map,20);
map.mapname = 'stdprofiling';
map = fix_prefix(map);
save_map(map);
save results_std_profiling.mat Imgs P map.mapname
