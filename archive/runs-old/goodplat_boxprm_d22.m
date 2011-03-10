repfile = 'plateaus/repdat.mat';
load ../thesis/good_plats.mat
depths = 18:2:20;
plats = good_plats;
dlen = 8;

[E D] = plateau_boxprm(plats,depths,dlen,repfile);
results = struct;
results.repfile = repfile;
results.data = D;
results.entropies = E;
results.depths = depths;
results.plats = plats;

save results_goodplat_boxprm_d20.mat results


