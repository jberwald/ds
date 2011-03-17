load ../plateaus/focm-data/goodplats.mat
load ../plateaus/focm-data/repdata.mat
tocheck = find(goodplat_checked < 0)
ents12 = zeros(size(goodplats));
data12 = repmat({[]},1,size(goodplats));
for plat = tocheck
  params = inf(reps(goodplats(plat),:))
  map = get_map('henon2',11,'params',params);
  map = refine_map(map,12);
  d = compute_symbolics(map.I,map);
  ents12(plat) = d.hmax;
  data12{end+1} = d;
end