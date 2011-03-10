results = struct;
results.repfile = 'plateaus/aprepdat.mat';
results.depths = [12:2:28];
plateaus = 9;
dlen = 8; % how many depths between d and d+2 ("subdepths")
dvec = 8:-1:1; % to fix the ordering problem in boxprm...
[E D] = plateau_boxprm(plateaus, results.depths, dlen, dvec, results.repfile);
results.entropies = E;
results.data = D;
save results_apboxprm_plat9_all.mat results


