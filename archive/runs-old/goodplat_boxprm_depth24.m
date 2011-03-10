repfile = 'plateaus/aprepdat.mat';
make_plateau_boxprm_trees(1:8, 20:2:24, 8, 1:8, repfile);
clear all;
close all;

repfile = 'plateaus/aprepdat.mat';
depths = 14:2:24;
plats = 1:8;
dlen = 8;

[E D] = plateau_boxprm(plats,depths,dlen,repfile);
results = struct;
results.repfile = repfile;
results.data = D;
results.entropies = E;
results.depths = depths;
results.plats = plats;
save results_apboxprm_b1_d24.mat results


