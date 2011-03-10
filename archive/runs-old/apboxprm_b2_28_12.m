repfile = 'plateaus/aprepdat.mat';
depths = 28;
plats = 9:12;
dlen = 8;
dvec = 8:-1:1;
[E D] = plateau_boxprm(plats,depths,dlen,dvec,repfile);
save results_apboxprm_b2_d28_12.mat


