map = get_map('henon3d',1);

depth = 3 * 15;
iterations = 75;
map.tree = crop_tree(map.tree);
ints = {map.h1}
for i=1:length(ints)
  map.tree = insert_iterates(map.tree, map.map, ints{i}, iterations, depth);
  map.tree = insert_iterates(map.tree, map.inverse, ints{i}, iterations, depth);
end

map.P = rigorous_matrix(map);

disp('growing invariant set...')
map = grow_ip_insert(map,struct);
disp('computing symbolics...')
data = compute_symbolics(map.I,map);


