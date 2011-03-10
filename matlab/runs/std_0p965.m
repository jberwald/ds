map = get_map('std',5,'params',infsup(0.965,0.970));
[map results] = homoclinic_driver(map,12);
save_map_special(map,'std_0p965');
save('std_0p965.mat','results')
