period = 8;
startd = 13;
finishd = 14;
mapname = 'lpa1p_s3';

map = get_map(mapname,startd);
%C = periodic_candidates(map.P,period);
boxes = map.tree.boxes(-1);
B = {};
for i = 1:length(C)
  B{i} = boxes(:,C{i});
end

for d = startd+1:finishd
  [B C] = pp_raf(map,period,d,B);
  map = get_map(mapname,d);
  PP = candidates_to_pps(C,map);
  save(sprintf('%s_orbits_p%id%i',mapname,period,d),'PP')
end
