function [R G M SM X A I tree P Adj Z] ...
	= onehs(mapname, depth, max_period, v, varargin)

% [R G M SM X A I tree P Adj Z] = ...
%	= onehs(mapname, depth, max_period, v, varargin)

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

  alledges = nchoosek(1:length(v),2);
  S = union_edges(sets, v(alledges)); % each edge is a set
  [R G M SM X A I Z] = compute_symbolics(S, tree, mapname, P, Adj, options);

  toc
end

