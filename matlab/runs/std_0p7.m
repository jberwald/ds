map = get_map('std',6,'params',0.7);
[map results] = homoclinic_driver(map,13);
save_map_special(map,'std_0p7');
save('std_0p7.mat','results')
