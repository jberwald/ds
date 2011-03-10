opts = struct('per2',1);
params = infsup(2.0,2.005);

% map = get_map('std',6,'params',params);
% [map dat] = homoclinic_driver(map,10,opts);
% save_map_special(map,'std_2p0_int_d10_per2');
% save std_2p0_int_d10_per2.mat dat

map = get_map('std',6,'params',params);
[map dat] = homoclinic_driver(map,9,opts);
save_map_special(map,'std_2p0_int_d9_per2');
save std_2p0_int_d9_per2.mat dat

% map = get_map('std',6,'params',params);
% [map dat] = homoclinic_driver(map,8,opts);
% save_map_special(map,'std_2p0_int_d8_per2');
% save std_2p0_int_d8_per2.mat dat
