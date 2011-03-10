function sets = pairwise_sets(prefix, PP, max_period, tree, P, Adj, skinny)

  setsfmt = [prefix '_p%d_sets.mat'];
  setsfile = sprintf(setsfmt,max_period);

  m = size(PP,1);
  
  [sets p] = get_baby_file(setsfmt, max_period, 'sets');
  fprintf('have pairwise sets up to period %d.\n',p);

  if (p < max_period)
	m_p = size(sets,1);					% how far we got
	sets_p = sets;
	sets = cell(m,m);
	sets(1:m_p,1:m_p) = sets_p;

	for j = 1 : m						% KLUDGE (the 2)
	  for k = max(m_p+1,j+1) : m		% start with new stuff
		fprintf('(%i,%i)\n',j,k)
		sets{j,k} = pairwise_connect(PP(:,1), [j k], P, skinny);
	  end	
	end

	save(setsfile,'sets');

  else

	sets = sets(1:m,1:m);

  end

end
