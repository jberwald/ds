repfile = 'plateaus/repdat.mat';
load ../thesis/good_plats.mat
make_plateau_boxprm_trees(good_plats, 24:2:26, 8, 1:8, repfile);

