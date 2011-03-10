load ../thesis/good_plats.mat
set(0,'RecursionLimit',200)
[E24_19 D24_19] = plateau_boxprm(good_plats(11:19),24,8);
save results_plats19_depth24.mat
