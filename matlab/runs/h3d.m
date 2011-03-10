map = get_map('henon3d',4);
[map results] = h3d_driver(map,8);
save_map_special(map,'h3d');
save('h3d.mat','results')
