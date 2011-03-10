box0 = [1.3,0.4];
boxn = 2*box0;
n = 30;						% # of steps between boxes

ents18 = box_test_hs('henon', 18, 8, box0, boxn, n);
save('boxscript_18_hs_8.mat','ents18');

ents16 = box_test_hs('henon', 16, 8, box0, boxn, n);
save('boxscript_16_hs_8.mat','ents16');

ents14 = box_test_hs('henon', 14, 8, box0, boxn, n);
save('boxscript_14_hs_8.mat','ents14');
