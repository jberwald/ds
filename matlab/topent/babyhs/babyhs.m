function [max_ent sets tree P Adj I] ...
	= babyhs(mapname, depth, max_period, varargin)

% [E sets max_ent tree P Adj I] ...
%	= babyhs(mapname, depth, max_period, varargin)

  tic
  
  [tree P Adj I options prefix] = get_map_old(mapname, depth, varargin{:});

  skinny = 0;
  if (~isempty(options))
	if (strfind(options,'skinny'))
	  skinny = 1;
	  prefix = [prefix '_skinny'];
	end
  end

  PP = get_orbits(prefix, max_period, P, Adj);
  sets = pairwise_sets(prefix, PP, max_period, tree,  P, Adj, skinny);

  max_ent = 0;
  for k = 1 : length(PP)
	Ek = clique_entropies(prefix, sets, max_period, k, tree, mapname, P, Adj);
	if (isempty(Ek))
	  break
	end

	max_ent = max(max_ent, max(cell2mat(Ek(:,2))));
  end

  toc
end

