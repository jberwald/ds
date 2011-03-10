load results_data/results_apboxprm_b2_d24.mat

C1 = plateau_contractions(D24,E24,1/4);
save results_apcons_1.mat C1

C2 = plateau_contractions(D24,E24,1/4);
save results_apcons_2.mat C2

C3 = plateau_contractions(D24,E24,1/4);
save results_apcons_3.mat C3

C4 = plateau_contractions(D24,E24,1/4);
save results_apcons_4.mat C4
