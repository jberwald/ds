map = get_map('std',8,'params',0.6);
[map results] = homoclinic_driver(map,14);
save_map_special(map,'std_0p6_d14');
save('std_0p6_d14.mat','results')
