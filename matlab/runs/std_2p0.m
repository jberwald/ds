
tstart = tic;
map = get_map('std',6,'params',2);
[map d8] = homoclinic_driver(map,8);
save_map_special(map,'std_2p0d8');
toc(tstart);

tstart = tic;
map = get_map('std',6,'params',2);
[map d9] = homoclinic_driver(map,9);
save_map_special(map,'std_2p0d9');
toc(tstart);

tstart = tic;
map = get_map('std',6,'params',2);
[map d10] = homoclinic_driver(map,10);
save_map_special(map,'std_2p0d10');
toc(tstart);

tstart = tic;
map = get_map('std',6,'params',2);
[map d11] = homoclinic_driver(map,11);
save_map_special(map,'std_2p0d11');
toc(tstart);

tstart = tic;
map = get_map('std',6,'params',2);
[map d12] = homoclinic_driver(map,12);
save_map_special(map,'std_2p0d12');
toc(tstart);

tstart = tic;
map = get_map('std',6,'params',2);
[map d13] = homoclinic_driver(map,13);
save_map_special(map,'std_2p0d13');
toc(tstart);

tstart = tic;
map = get_map('std',6,'params',2);
[map d14] = homoclinic_driver(map,14);
save_map_special(map,'std_2p0d14');
toc(tstart);

%map = get_map('std',6,'params',2);
%[map d15] = homoclinic_driver(map,15);
%save_map_special(map,'std_2p0d15');
%toc(tstart);

save std_2p0.mat d*
