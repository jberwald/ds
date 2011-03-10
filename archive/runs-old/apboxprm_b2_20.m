repfile = 'plateaus/aprepdat.mat';
depths = 12:2:20;
plats = 9:16;
[E D] = plateau_boxprm(plats,depths,8,repfile);
save results_apboxprm_b2_d20.mat


