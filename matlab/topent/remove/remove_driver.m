function [R G M SM X A I tree P Adj Z] = remove_driver(mapname, depth, num_preimages, ...
												  varargin)
% [R G M SM X A I tree P Adj Z] = remove_driver(mapname, depth, num_preimages, ..,)

tic

  [tree P Adj I_tree options] = get_map_old(mapname, depth, varargin{:});

  fprintf('removing %i preimages of the gap...',num_preimages)
  S = remove_preimages(tree, P, Adj, mapname, depth, num_preimages);
  S = intersect(S,I_tree);
  fprintf(' %d boxes left\n',length(S))
  
  [R G M SM X A I Z] = compute_symbolics(S, tree, mapname, P, Adj, options);

toc
