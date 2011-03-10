load ../thesis/good_plats.mat
[E D] = plateau_boxprm(good_plats(20:end),12:2:20,4);
save results_goodplat_boxprm_20_end.mat
