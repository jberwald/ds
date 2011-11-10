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

  % default values: no cutoff, no options
  if nargin < 3:
    min_entropy = 0;
  end
  if nargin < 4:
    options = struct;
  end
  
  % 1. Remove transient generators.
  % Theorem: we can use a smaller shift equivalence representative for the
  % index map.  We compute this representative using the same graph_mis
  % routine used to find a graph invariant set.
  [M_inv notinv] = restrict_to_inv(M);
  G_inv = trim_generators(G,notinv);
  
  % 2. Compute "upper bound" symbol matrix.
  % As a start to computing the final symbol matrix SM, contract all
  % generators within each region -- that is, if any generator from region i
  % maps (with any nonzero coefficient!) to a generator from region j, add
  % the edge (j,i).  This is the most optimistic symbol transition matrix
  % possible, but we will refine it by removing bad edges.
  SM = contract_map(G_inv,M_inv);
  
  % 3. Compute problem edge sets
  % This is a collection BES = {E_i} of "bad edge sets", where each E_i =
  % {e_1, e_2, ...} is just a list of edges.  The important property is that
  % if at least one edge from each edge set E_i is removed from SM, then the
  % resulting symbol matrix has been rigorously verified.  In CS parlance, we
  % need only cut a hitting set of BES -- a set E such that E\cap E_i\neq
  % \emptyset for all i.  Here 'probedges' is this collection BES.
  lef =  Lefschetzer(M_inv,G_inv);      
  lef = computeBadEdgeSets(lef,30);     % figure out what edge sets to cut
  probedges = getBadEdgeSets(lef);      % extract the edge sets
  convert = @(E) edge2num(E,length(G_inv))'; % hash function
  numids = cellfun(convert, probedges, 'uniformoutput', 0); % hash each edge

  % 4. Find the optimal edge set to cut
  % By optimal, we mean maximal entropy -- we wish to find the hitting set E
  % such that h(SM-E) is maximized.  The arguments to this function are funny
  % because it's written recursively.  Basically, search_edges is an
  % exhaustive search with pruning.
  [edges e c] = search_edges(SM,numids,[],[],[],-1,100000);
  edges = num2edge(edges,length(G_inv))';

  % It is technically possible that no such edge set E was found... instead
  % of aborting though, we should probably just cut E_i(1) for all i (the
  % first edge in each set.  But reallly this shouldn't even happen anyway.
  if (c == 0)
	disp('\n search_edges reached cutoff time');
	if (isempty(edges))					% didn't find a valid edge set
	  SM = [0];							% have to abort
	  return
	end
  end
  
  % 5. Cut and trim SM
  % First, we cut the edges we were supposed to.  But also, we must restrict
  % SM to the strongly-connected components, since we can't actually prove
  % one-way connections or transient edges -- only components made of cycles
  % can be verified.
  SM = kill_edges(SM,edges);            % kill the edges
  SM = restrict_to_sccs(SM);            % can't prove one-way connections

end


function G = trim_generators(G, to_trim)
  for r = 1 : length(G)
	G{r} = setdiff(G{r},to_trim);	% remove and relabel
  end
end
