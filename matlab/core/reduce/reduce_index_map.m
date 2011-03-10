%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% reduce_index_map - 8/4/2008
%
%   Creates a symbol transition matrix SM by proving the existence of each
%   cycle in SM using the Lefschetz Fixed Point Theorem in conjuntion with
%   the map on homology.  The phase space is assumed to be split into
%   disjoint regions.
%
% input: (M, G [, min_entropy])
%
%   M - map on homology for the space
%   G - cell array s.t. G{r} is the generators on homology of the rth region
%   min_entropy - optional pruning parameter: ignore SM if ent(SM < min_entropy
%   search_cutoff - optional cutoff parameter: give up after search_cutoff steps
%
% output: [SM M_inv G_inv ProbR prob_paths]
%
%   SM - the rigorous symbol transition matrix
%   M_inv - index map with transient generators removed
%   G_inv - non-transient generators of G
%   ProbR - regions with more than one generator of homology (debug)
%   prob_paths - edges corresponding to Lefschetz violations (debug)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [SM M_inv G_inv probedges] = ...
	  reduce_index_map(M, G, min_entropy, options)

  [M_inv notinv] = restrict_to_inv(M);  % Thm: can use smaller rep for index
  G_inv = trim_generators(G,notinv);    % get rid of transient generators
  lef =  Lefschetzer(M_inv,G_inv);
  lef = computeBadEdgeSets(lef,30);
  probedges = getBadEdgeSets(lef);
  SM = contract_map(G_inv,M_inv);                      

  convert = @(E) edge2num(E,length(G_inv))';
  numids = cellfun(convert, probedges, 'uniformoutput', 0);

  [edges e c] = search_edges(SM,numids,[],[],[],-1,50000);
  edges = num2edge(edges,length(G_inv))';

  if (c == 0)
	disp('\n search_edges reached cutoff time');
	if (isempty(edges))					% didn't find a valid edge set
	  SM = [0];							% have to abort
	  return
	end
  end
  
  SM = kill_edges(SM,edges);			% kill the edges
  SM = restrict_to_sccs(SM);  % can't prove transient edges or one-way connections

end


function G = trim_generators(G, to_trim)
  for r = 1 : length(G)
	G{r} = setdiff(G{r},to_trim);	% remove and relabel
  end
end
