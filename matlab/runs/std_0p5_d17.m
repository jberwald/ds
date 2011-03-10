map = get_map('std',8,'params',0.5);
[map results] = homoclinic_driver(map,17);
save_map_special(map,'std_0p5_d17');
save('std_0p5_d17.mat','results')
