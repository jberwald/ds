function Ek = clique_entropies(prefix, sets, max_period, k, tree, mapname, P, Adj)
% assume: file for k-1 at period max_period exists.

  Ek1file = [prefix sprintf('_p%i_%i',max_period,k-1) 'cliques.mat'];
  Ekfmt = [prefix '_p%d_' sprintf('%i',k) 'cliques.mat'];
  Ekfile = sprintf(Ekfmt, max_period);
  m = size(sets,1);

  if (k==1)								% trivial case; return garbage
	Ek = cat(2, num2cell((1:m)'), repmat({eps},m,1));
	save(Ekfile,'Ek');
	return;
  end

  load(Ek1file);						% loads "Ek" ...
  Ek1 = Ek;								% ... which is really E_{k-1}
  clear Ek;								% delete "Ek" so it's not confusing

  [Ek p] = get_baby_file(Ekfmt,max_period,'Ek');

  if (p == max_period)					% exactly what we needed

	return

  elseif (p < max_period)				% need to add up to max_period

	% find all sets of k vertices such that each of the k subsets of size k-1
    % had entropy in E_{k-1}... this is equivalent to a cycle in the
    % (k-1)-uniform hypergraph whose edges are the vertex sets in Ek1

	nonzero_k1_ents = find(cell2mat(Ek1(:,2)));
	hypergraph = cell2mat(Ek1(:,1));
	hypergraph = hypergraph(nonzero_k1_ents,:);
	kcliques = hypergraph_cycles(hypergraph);

	if (isempty(Ek))					% Ek == []
	  Ek = {};
	else
	  Ek_cliques = cell2mat(Ek(:,1))	% already did these
	  kcliques = setdiff(kcliques,Ek_cliques,'rows');
	end

	alledges = nchoosek(1:k,2);

	for r = 1 : size(kcliques,1)
	  clique = kcliques(r,:);
	  fprintf('%d : ',clique);
	  S = union_edges(sets,clique(alledges)); % each edge is a set
	  [R G M SM] = compute_symbolics(S,tree,mapname,P,Adj,'quiet');
	  tp = log_max_eig(SM);
	  
	  fprintf(' %3.4f',tp)
	  if (tp > 0 && higher_clique_entropy(clique,tp,Ek1))
		Ek(end+1,:) = {clique tp};
	  else
		fprintf(' (redundant)')
	  end
	  fprintf('\n')
	end

  else									% p > max_period: more than enough

	Ek_cliques = cell2mat(Ek(:,1));
	[rows cols] = find(Ek_cliques > m); % use a higher per. orbit
	keep_me = setdiff(1:size(Ek_cliques,1), rows);
	Ek = Ek(keep_me,:);

  end

  save(Ekfile,'Ek');

end
