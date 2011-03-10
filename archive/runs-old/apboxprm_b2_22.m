repfile = 'plateaus/aprepdat.mat';
depths = 22;
plats = 9:16;
[E D] = plateau_boxprm(plats,depths,8,repfile);
save results_apboxprm_b2_d22.mat
