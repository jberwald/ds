depth = 10;
trials = 12;

for t = 1 : trials

  map = get_map('henon',0);

  to_be_subdivided = 8; % flag for subdivision
  delbox = 1;

  for d = 1 : depth
    tic;
	for j = 1 : map.tree.dim
	  map.tree.set_flags('all', to_be_subdivided);
	  map.tree.subdivide;
	end
	times{1}(d,t) = toc;
    
    fprintf('step %d: ', d);

    tic;
	map.P = rigorous_matrix(map);
	map.Adj = adj_matrix(map); % compute the adjacency matrix
	times{2}(d,t) = toc;
    
    tic;
    n = size(map.P, 1);
    I = graph_mis(map.P);
    times{3}(d,t) = toc;
    
    tic;
    inv_bits = repmat('0', [1 n]);
    inv_bits(I) = '1';					% 11/18/2006
    map.tree.set_flags(inv_bits, delbox); 	% flag boxes in I + X
    map.tree.remove(delbox);				% remove non-flagged boxes
    times{4}(d,t) = toc;
    
    fprintf('%d boxes in I, %d boxes total  ', ...
				 length(I), map.tree.count(-1));
    
    fprintf('\n')
  end
  
  delete map.tree;
  clear map.tree;
  
end

save('matlab/rads/mtest_times.mat','times')