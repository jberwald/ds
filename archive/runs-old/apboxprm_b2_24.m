repfile = 'plateaus/aprepdat.mat';
depths = 24;
plats = 9:16;
dlen = 8;
[E D] = plateau_boxprm(plats,depths,dlen,repfile);
save results_apboxprm_b2_d24.mat


