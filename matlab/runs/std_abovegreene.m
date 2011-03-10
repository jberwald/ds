opts = struct('per2',1);

params = infsup(2.0,2.002);
fname = 'std_2p0_002'

params = infsup(1.0,1.002);
fname = 'std_1p0_002'

depth = 10;
map = get_map('std',6,'params',params);
[map dat] = homoclinic_driver(map,depth,opts);
save_map_special(map,sprintf('%s_d%i',fname,depth));
save([fname '.mat'],'dat')

opts = struct;
fname = 'std_1p0_002_noper2'

depth = 10;
map = get_map('std',6,'params',params);
[map dat] = homoclinic_driver(map,depth,opts);
save_map_special(map,sprintf('%s_d%i',fname,depth));
save([fname '.mat'],'dat')

depth = 9;
map = get_map('std',6,'params',params);
[map dat] = homoclinic_driver(map,depth,opts);
save_map_special(map,sprintf('%s_d%i',fname,depth));
save([fname '.mat'],'dat')

