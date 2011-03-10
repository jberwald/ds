function PP = get_orbits(map, period, opts)
% function PP = get_orbits(map, period, opts)
  
  orbitfmt = [map.prefix '_orbits_p%s.mat'];
  [s r] = unix(['ls ' sprintf(orbitfmt,'*')]);
  if s==0
    t = regexp(r,sprintf(orbitfmt,'(\\d+)\\'),'tokens');
    p = max(cellfun(@(x) eval(x{1}),t));
    load(sprintf(orbitfmt,sprintf('%i',p)));
  else
    p = 0;
  end

  if (p < period)	% might as well just start over

	fprintf('computing orbits up to period %d...\n', period)
    if (isfield('startdepth',
    [B C] = pp_raf(map
	PP = list_pps(max_period, P, Adj);
	fprintf(' %d orbits found\n', size(PP,1))
	save(orbitfile,'PP');

  else

	fprintf('have orbits up to period %d.\n', p)
	if (~isempty(PP))
	  inds = find(cell2mat(PP(:,2)) <= max_period); % just up to max_periood
	  PP = PP(inds,:);
	end
	save(orbitfile,'PP');
  
  end

end
