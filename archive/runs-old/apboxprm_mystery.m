repfile = 'plateaus/aprepdat.mat';
depths = 12;
plats = 9;
[E D] = plateau_boxprm(plats,depths,128,repfile);
save results_apboxprm_mystery.mat
