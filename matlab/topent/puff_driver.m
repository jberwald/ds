function [R G M SM X A I tree P Adj Z] = puff_driver(mapname, depth, max_period, varargin)
% function [R G M SM X A I tree P Adj Z] = puff_driver(mapname, depth, max_period, varargin)
% Z = {G_inv M_inv idstr}

tic

  [tree P Adj I_tree options] = get_map_old(mapname, depth, varargin{:});

  if (strfind(options,'quiet'))
	status = 0;
  else
	status = 1;
  end

  P_I = P(I_tree,I_tree);
  Adj_I = Adj(I_tree,I_tree);

  if (status),  fprintf('computing orbits up to period %d...', max_period), end
  [S I_current] = rodrigo_orbits(max_period, [], P_I, Adj_I);
  if (status), fprintf(' %d boxes added\n', length(S)), end

  if (status), fprintf('computing connections...'), end
  conns = find_connections(S,S,P_I);
  if (status), fprintf(' %d boxes added\n', length(conns)), end

  %%%
  %  boxes = tree.boxes(-1);
  
  %  figure
  %  set(gcf,'name','Orbits and Connections');
  %  showraf(boxes(:,conns)','g','g');
  %  showraf(boxes(:,S)','b','b');
  %%%

  S = union(conns, S);
  S = I_tree(S);

  [R G M SM X A I Z] = compute_symbolics(S, tree, mapname, P, Adj, options);

toc
