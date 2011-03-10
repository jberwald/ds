d = 13;
fval = 66;
mapname = 'lpa1p';
imgname = sprintf('%s-%i-d%i',mapname,fval,d);

map = get_map('lpa1p',1,'params',fval);
f_1 = map.map;
map = get_map('lpa1p_s3',1,'params',fval);
f_3 = map.map;
map.map = f_1;                          % use the scalar map for the iterates
map.tree = crop_tree(map.tree);
v = [20 20 20]; %v = [30 10 5]; % v = [10 1 1];
map = insert_attractor(map,v,40000,[1 1 1]*0.0000001,d,1000);
map.map = f_3;
disp('growing invariant set...')
map = grow_ip_insert_faster(map,struct('imgname',imgname,'imgsteps',1));
disp('computing symbolics...')
dat = compute_symbolics(map.I,map,{'noims'});

% k = 5; % max period
% d = 9; % depth

% map = get_map('lpa1p_s2',4); 
% C1 = pp_map(map,k,d)
% map = get_map('lpa1p_s2',d); 
% %C2 = periodic_candidates(map.P, k)

% PP1 = candidates_to_pps(C1,map.P,map.Adj)
% %PP2 = candidates_to_pps(C2,map.P,map.Adj) 