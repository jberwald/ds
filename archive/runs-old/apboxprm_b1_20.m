repfile = 'plateaus/aprepdat.mat';
depths = 14:22;
plats = 1:8;
dlen = 8;
[E D] = plateau_boxprm(plats,depths,dlen,repfile);
results = struct;
results.repfile = repfile;
results.data = D;
results.entropies = E;
results.depths = depths;
results.plats = plats;
save results_apboxprm_b1_d20.mat results


