function max_ent = babynoconns(map, max_period)

  tic

  prefix = ['baby' map.prefix];
    
  PP = get_orbits(prefix, max_period, map.P, map.Adj);
  m = size(PP,1);
  
  sets = {};
  for j = 1 : m
    for k = j+1 : m
      sets{j,k} = union(PP{j,1}, PP{k,1});
    end	
  end
  
  max_ent = 0;
  for k = 1 : length(PP)
	Ek = clique_entropies(prefix, sets, max_period, k, map);
	if (isempty(Ek))
	  break
	end

	max_ent = max(max_ent, max(cell2mat(Ek(:,2))));
  end

  toc
end

