repfile = 'plateaus/aprepdat.mat';
depths = 28;
plats = 9:16;
dlen = 8;
dvec = 8:-1:1;
[E D] = plateau_boxprm(plats,depths,dlen,repfile);
save results_apboxprm_b2_d28.mat


