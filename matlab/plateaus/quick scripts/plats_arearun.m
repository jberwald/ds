load aprepdat

plat = 14;
depths = 6:10;
steps = 20;

% plats_areatrees([ap_reps(plat) -1], depths, steps); DONE
[E D] = plats_areascale([ap_reps(plat) -1], depths, steps);
fname = sprintf('../plateaus/focm-data/scaletest-depth%ito%i-applat%i.mat',depths(1),depths(end),plat);
save(fname,'E','D','plat','depths','steps')
