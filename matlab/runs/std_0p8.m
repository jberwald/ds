map = get_map('std',5,'params',0.8);
[map results] = homoclinic_driver(map,13);
save_map_special(map,'std_0p8');
save('std_0p8.mat','results')
