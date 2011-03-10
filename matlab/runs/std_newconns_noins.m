map = get_map('std',2,'params',0.9);
depth1 = 2 * 6;
depth2 = 2 * 12;
its = 8; % # of iterations forward and back

e = map.params;
f = @(v) mod([v(1) + v(2) + (e/(2*pi))*sin(2*pi*v(1)); v(2) + (e/(2*pi))*sin(2*pi*v(1))],1);
finv = @(v) mod([v(1) - v(2); v(2) - (e/(2*pi))*sin(2*pi*(v(1)-v(2)))],1);

map.tree = crop_tree(map.tree);
[x1 y1 x2 y2] = draw_invariant_manifolds2(map.params);
ints = {[0.5; y1] [.5; 1-y1] [x2; y2] [1-x2; 1-y2]};  % intersections
points = [];
for i=1:length(ints)
  [map.tree p] = insert_iterates(map.tree, f, ints{i}, its, depth1);
  points = [points p];
  [map.tree p] = insert_iterates(map.tree, finv, ints{i}, its, depth1);
  points = [points p];
end

map = insert_onebox(map);
  
for j = depth1+1 : depth2
  map.tree.set_flags('all', 8);
  map.tree.subdivide;
end

boxes = map.tree.boxes(-1);
radius = boxes(map.tree.dim+1:end,1) * 1.1;
points = [points; repmat(radius, 1, size(points,2))];
S = search_boxes_set(map.tree, points);

showraf(boxes','y','y');
for i=1:length(ints)
  showraf(boxes(:,map.tree.search(ints{i}))','b','b');
end

disp('picture')

%pause
close

disp('growing invariont set...')
map = grow_ip_noinsert(map,S,struct('imgname','std-newconns'));
%disp('computing symbolics...')
%data = compute_symbolics(map.I,map,{'noims'});


