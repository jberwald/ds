map = get_map('std',8,'params',0.550);
[map results] = homoclinic_driver(map,14);
save_map_special(map,'std_0p550_d14_map');
save('std_0p550_d14.mat','results')
