m = get_map('oneisland',8)
%p = find(diag(m.P^4));
%compute_symbolics(p,m);

  max_period = 1;
  status = 1;

  if (status),  fprintf('computing orbits up to period %d...', max_period), end
  [S I_current] = rodrigo_orbits(max_period, [], m.P, m.Adj);
  if (status), fprintf(' %d boxes added\n', length(S)), end

  if (status), fprintf('computing connections...'), end
  conns = find_connections(S,S,m.P);
  if (status), fprintf(' %d boxes added\n', length(conns)), end

  %%%
  %  boxes = tree.boxes(-1);
  
  %  figure
  %  set(gcf,'name','Orbits and Connections');
  %  showraf(boxes(:,conns)','g','g');
  %  showraf(boxes(:,S)','b','b');
  %%%

  S = union(conns, S);

  [R G M SM X A I Z] = compute_symbolics(S, m);

SM{:}
