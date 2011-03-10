function map = mistpuff(map, depth)
% map = mistpuff(map, depth)
% subdivides to tree depth: tree.dim * depth
%   (e.g. for henon, mistpuff_map(m,10) goes to depth 20
% adds the exit set in a one box neighborhood of the tree
  
  dim = map.tree.dim;
  start_depth = (map.tree.depth / dim) + 1;
  to_be_subdivided = 8; % flag for subdivision
  delbox = 1;

  if (depth < start_depth)
	fprintf('WARNING: mistpuff called at depth %i and final depth %i\n',start_depth-1,depth);
  end

  for d = start_depth : depth
	for j = 1 : dim
	  map.tree.set_flags('all', to_be_subdivided);
	  map.tree.subdivide;
	end
	
    fprintf('step %d: ', d);

	map.P = rigorous_matrix(map);
	map.Adj = adj_matrix(map); % compute the adjacency matrix
	
    n = size(map.P, 1);
    
	boxes = map.tree.boxes(-1);				    % 11/18/2006
    [I, I_f] = graph_mis_puff(map.P, map.Adj);	% 11/18/2006
% 	X = intersect(onebox(I, map.Adj), I_f);	    % candidates for exit set
% 	X_img = find(map.P*flags(X, n));			% image of exit set boxes
%   S = union(I, union(X, X_img));
    S = union(I, mapimage(map.P,I));
    
    inv_bits = repmat('0', [1 n]);
    inv_bits(S) = '1';					% 11/18/2006

    map.tree.set_flags(inv_bits, delbox); 	% flag boxes in I + X
    map.tree.remove(delbox);				% remove non-flagged boxes
    
    fprintf('%d boxes in I, %d boxes total\n', ...
				 length(I), map.tree.count(-1));
  end
  
  map.I = search_boxes(map.tree, boxes(:,I));
  S_new = search_boxes(map.tree, boxes(:,S));
  S_new_inv = inv_perm(S_new, length(S));
  map.P = map.P(S,S);
  map.P = map.P(S_new_inv, S_new_inv);
  map.Adj = map.Adj(S,S);
  map.Adj = map.Adj(S_new_inv, S_new_inv);
  map.depth = depth;

end
