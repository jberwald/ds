map = get_map('std',8,'params',0.6);
[map results] = homoclinic_driver(map,16);
save_map_special(map,'std_0p6');
save('std_0p6.mat','results')
