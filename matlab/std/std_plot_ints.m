function std_plot_ints(eps1,eps2,width,depth,opts)

  E = [0]

  epsilons = eps1 : width : eps2

  for eps = epsilons(1 : end-1)
	fname = strrep(sprintf('std_%1.3f_005',eps),'.','p')
	load(['output/' fname '.mat'])
	entropy = max(cellfun(@log_max_eig, dat.SM)); % max of the dims
	E = [E entropy];
  end

  stairs(epsilons, E)
end
