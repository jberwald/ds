opts = struct('per2',1);
eps = 3.0;

map = get_map('std',6,'params',eps);
[map dat] = homoclinic_driver(map,10,opts);
save_map_special(map,'std_3p0d10_per2');
save std_3p0d10_per2.mat dat

map = get_map('std',6,'params',eps);
[map dat] = homoclinic_driver(map,9,opts);
save_map_special(map,'std_3p0d9_per2');
save std_3p0d9_per2.mat dat

map = get_map('std',6,'params',eps);
[map dat] = homoclinic_driver(map,8,opts);
save_map_special(map,'std_3p0d8_per2');
save std_3p0d8_per2.mat dat

map = get_map('std',6,'params',eps);
[map dat] = homoclinic_driver(map,7,opts);
save_map_special(map,'std_3p0d7_per2');
save std_3p0d7_per2.mat dat
