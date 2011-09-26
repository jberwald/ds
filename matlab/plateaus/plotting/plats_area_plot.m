load ../plateaus/focm-data/areatest-depth6to10-applat14.mat
load aprepdat

params = [ap_reps(plat) -1];
map = get_map('henon2',depths(1),'params',params);
a0 = prod(map.radius);

A = zeros(1,length(depths)*steps);
for s=1:steps*length(depths)
  [depth box d] = plats_num2depth(s,depths,steps);
  map = get_map('henon2',depth,'params',params,'box',box);
  boxes = map.tree.boxes(-1);
  A(s) = log(prod(boxes(3:4,1)))-log(a0);
end

A = [A(1)+0.3 A];
E = [0 E];

plot(-A,E,'b-') 
ylim([-0.02 0.73])
xlim([-A(1) -A(end)])

%plats_savefig('area-scale',0.5)