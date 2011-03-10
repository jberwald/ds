function data = puff_driver_map(map, max_period, varargin)
% data = puff_driver_map(map, max_period, varargin)

tic
  status = 1;

  if (status),  fprintf('computing orbits up to period %d...', max_period), end
  [S I_current] = rodrigo_orbits(max_period, [], map.P, map.Adj);
  if (status), fprintf(' %d boxes added\n', length(S)), end

  if (status), fprintf('computing connections...'), end
  conns = find_connections(S,S,map.P);
  if (status), fprintf(' %d boxes added\n', length(conns)), end

  S = union(conns, S);

  data = compute_symbolics(S, map);

toc
