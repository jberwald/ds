function std_fix_ints(eps1,eps2,width,depth,opts)

  epsilons = eps1 : width : eps2

  for eps = epsilons(1 : end-1)
	fname = strrep(sprintf('std_%1.3f_005',eps),'.','p')
	map = get_map_special('std',sprintf('%s_d%i',fname,depth));
	dat = compute_symbolics(map.I,map,{'noims'});
	save(['output/' fname '.mat'],'dat')
  end

end
