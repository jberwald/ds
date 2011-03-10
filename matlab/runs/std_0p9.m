map = get_map('std',6,'params',0.9);
[map results] = homoclinic_driver(map,12);
save_map_special(map,'std_0p9');
save('std_0p9.mat','results')
