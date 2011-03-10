final_depth = 12;

map = get_map('henon3d', 1);
map.tree = crop_tree(map.tree);
map.tree.insert(map.p0, final_depth*3);
map.tree.insert(map.p1, final_depth*3);
map.depth = final_depth;

disp('growing invariant set faster...')
tic
  map = grow_ip_insert_faster(map);
toc

