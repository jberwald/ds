function tree=lpa_raf(new_mis, depth)

  % Defining the LPA model

  m = Model('lpa');
  map_lpa = Integrator('Map');
  map_lpa.model = m;
  map_lpa.tFinal = 1;
  m.dim = 3;

  % Parameters p. 86
  m.b = 7.876;
  m.cea = .01114;
  m.cel = 0.01385;
  m.cpa = 0.5;
  m.ul = 0.1613;
  m.ua = 0.96;

  % Evaluate the map

  k_0 = 50;
  k_iter = 500000;

  % Initial population densities
  x0 = [ 250 ;5 ;100 ];

  orbit = map_lpa.eval(x0,k_iter);
  mn = min(orbit(:,k_0:k_iter),[],2)';
  mx = max(orbit(:,k_0:k_iter),[],2)';

  c = (mn + mx)/2;
  r = 2*(mx-mn)/2;

  tree = Tree(c(1:m.dim), r(1:m.dim));
  tree.integrator = map_lpa;

  pts = Points('Grid',m.dim,5000);
  tree.domain_points = pts;
  tree.image_points = Points('Vertices',m.dim);

  if (new_mis)

	cut_depth = 24;
	
    [I,A] = mist(tree,cut_depth);
	figure; plotb(tree, [1,2,3], 'g');
	
    S = find(diag(A))
    I = grow_isolated(S, A, tree, cut_depth);
    n = size(tree.boxes(-1),2)
    notI = setdiff(1:n,I);
    Attractor = notI(graph_mis(A(notI,notI)));
    remove(tree,Attractor);
	figure; plotb(tree, [1,2,3], 'g');

    [I,A] = mist(tree,depth, cut_depth+1);
    
	%[I,A]=mist(tree,depth);
    %remove_transience(tree,depth);
    %pp(tree,3,depth);
  else
    mis(tree, depth);
    % size(tree.matrix(lip))
  end

  tree.count(-1)
  figure; plotb(tree, [1,2,3], 'g');
