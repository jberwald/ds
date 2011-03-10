repfile = 'plateaus/aprepdat.mat';
depths = 26;
plats = 9:16;
dlen = 8;
[E D] = plateau_boxprm(plats,depths,dlen,repfile);
save results_apboxprm_b2_d26.mat


