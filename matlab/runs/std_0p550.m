opts = struct;
opts.actionoffset = -1;		% use action, default offset

map = get_map('std',6,'params',0.55);
depth = 15;
fname = strrep(sprintf('std_%1.3f_d%i',map.params,depth),'.','p')
disp('computing homoclinic insertion...')
map = homoclinic_insertion_skinny(map, depth, opts)
disp('growing invariant set faster...')
tic
  [map ImgCell T_fast] = grow_ip_insert_faster(map,opts);
toc
disp('computing symbolics...')
dat = compute_symbolics(map.I,map,{'noims'});
save_map_special(map,[fname '_map']);
save([fname '.mat'],'dat')
