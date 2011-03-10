function paranoid_remove_24_reduce_func()

do_reduce('topdata/henon_puffed_24_remove_13_');
do_reduce('topdata/henon_puffed_24_remove_12_');
do_reduce('topdata/henon_puffed_24_remove_11_');

end

function do_reduce(prefix)
  ['~/paranoid/' prefix 'MG.mat']
  load(['~/paranoid/' prefix 'MG.mat'])
  fprintf('reducing index map...')
  [SM M_inv G_inv] = reduce_index_map_paranoid(M,G,prefix);
  fprintf(' entropy = %f\n',log_max_eig(SM))
  save(['~/paranoid/' prefix 'SM.mat'],'SM','M_inv','G_inv')
end

