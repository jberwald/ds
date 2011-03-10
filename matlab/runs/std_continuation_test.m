oldeps = 822;
neweps = 821;
olddepth = 11;
newdepth = 11;

namepat = 'std_cont_0p%i_d%i';
oldname = sprintf(namepat,oldeps,olddepth)
newname = sprintf(namepat,neweps,newdepth)

fprintf('retrieving map for eps = 0.%i...',oldeps)
[map dat] = get_run('std',oldname);
oldboxes = map.tree.boxes(-1);
showset(map,1:length(map.P),'g');

fprintf('inserting its IP at depth %i for eps = 0.%i...',newdepth,neweps)
map = get_map('std',1,'params',neweps/1000);
map.tree.unset_flags('all',8);
map.tree.remove(8); % fresh tree

% put the old ip in the new tree
map.tree.insert(oldboxes(1:2,dat.X),newdepth*2);
map.depth = newdepth % fix depth

opts = struct;
if isintval(map.params)
  epsilon = (inf(map.params) + sup(map.params)) / 2;
else
  epsilon = map.params;
end
map.P = rigorous_matrix(map);
map.Adj = adj_matrix(map);
C = homoclinic_points(epsilon, map.depth, opts);
S = connection_set(map,C,opts);
I = grow_iso_raf(S,map.P,map.Adj);
length(I)
disp('have to change grow_ip_insert back...')
map.I = S;
hold on
showset(map,map.I,'b');
figure
showset(map,map.I,'b');
pause

disp('growing invariant set...')
opts.imgname = newname;
map = grow_ip_insert(map,opts);

disp('computing symbolics...')
dat = compute_symbolics(map.I,map,{'noims'});

save_run(map,dat,newname);
