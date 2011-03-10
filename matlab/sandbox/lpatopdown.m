d = 14;
map = get_map('lpa1p',4,'params',58);
f_1 = map.map;
map = get_map('lpa1p_s3',4,'params',58);
f_3 = map.map;
map.map = f_1;                          % use the scalar map for the iterates
map.tree = crop_tree(map.tree);
v = [30 10 5]; % v = [10 1 1];
disp('inserting attractor...')
[map points] = insert_attractor(map,v,40000,[1 1 1]*0.1,d,10000);
map.map = f_3;
fprintf('  %i boxes added\n',map.tree.count(-1));
disp('recovering attractor points')
S = search_boxes(map.tree,points(30000:end,:)');
disp('computing transition matrix')
map.P = rigorous_matrix(map);
disp('computing adjacency matrix')
map.Adj = adj_matrix(map);
dat = compute_symbolics(S,map);