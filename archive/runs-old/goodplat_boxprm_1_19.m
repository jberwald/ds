load ../thesis/good_plats.mat
[E D] = plateau_boxprm(good_plats(1:19),12:2:20,4);
save results_goodplat_boxprm_1_19.mat
