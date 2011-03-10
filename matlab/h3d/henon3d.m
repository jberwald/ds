function [map data] = henon3d(final_depth)

map = get_map('henon3d', 1);
map.tree = crop_tree(map.tree);
map.tree.insert(map.p0, final_depth*3);
map.tree.insert(map.p1, final_depth*3);
map.depth = final_depth;

disp('growing invariant set...')
map = grow_ip_insert(map);

disp('computing symbolics...')
data = compute_symbolics(map.I,map,{'noims'});
