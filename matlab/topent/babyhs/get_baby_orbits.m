function PP = get_baby_orbits(prefix, max_period, P, Adj)
% function PP = get_baby_orbits(prefix, max_period, P, Adj)
% function PP = get_baby_orbits(map, max_period)

  if nargin == 2
    map = prefix;
    P = map.P;
    Adj = map.Adj;
    prefix = map.prefix;
  end
  
  max_search_period = 12;

  orbitfmt = ['baby' prefix '_p%d_orbits.mat'];
  orbitfile = sprintf(orbitfmt,max_period);

  [PP p] = get_baby_file(orbitfmt, max_period, 'PP');

  if (p < max_period)					% might as well just start over

	fprintf('computing orbits up to period %d...', max_period)
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
