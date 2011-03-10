map = get_map('henon3d',2);

depth = 3 *10;
iterations = 60;
map.tree = crop_tree(map.tree);

map.tree.insert(map.p0,depth);
map.tree.insert(map.p1,depth);

%ints = {map.h1}
%for i=1:length(ints)
%  map.tree = insert_iterates(map.tree, map.map, ints{i}, iterations, depth);
%  map.tree = insert_iterates(map.tree, map.inverse, ints{i}, iterations, depth);
%end

%map.P = rigorous_matrix(map);

% p0 = map.tree.search(map.p0);
% p1 = map.tree.search(map.p1);
% plotb(map.tree);
% boxes = map.tree.boxes(-1);
% show3(boxes(:,p0)','b');
% show3(boxes(:,p1)','c');

disp('growing invariont set...')
map = grow_ip_insert(map,struct);
disp('computing symbolics...')
data = compute_symbolics(map.I,map,{'noims'});


