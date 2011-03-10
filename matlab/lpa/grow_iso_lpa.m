function Inv_oI = grow_iso_lpa(S, tree, depth)

% This function grows an isolating nbhd around the invariant set S. It also
% maps the one box nbhd around the invariant set foward, using interval arithmetic,
% so that no empty image problems will occur when computing the homology.

  I = S;
  oI = get_1BoxNbhd(tree,I,depth);

  P = rigorous_matrix(tree,depth,@lpa_intmap);    % Recompute the transition matrix

  Inv_oI = oI(find(max_inv_set(P(oI,oI))));

  while ~lpa_in_int(tree,Inv_oI, oI,depth)    %Test if Inv_oI is in oI
	oI = get_1BoxNbhd(tree,Inv_oI,depth);
	
    P = rigorous_matrix(tree,depth,@lpa_intmap);
    
    Inv_oI = oI(find(max_inv_set(P(oI,oI))));
  end

  fprintf('Isolated! \n');

  b = tree.boxes(depth);
  d = tree.dim;

  %Get the center of the boxes in the invariant set.
  for i = 1 : length(Inv_oI)
    cInv(:,i) = b(1:d,Inv_oI(i));
  end

  oI = setdiff(oI,Inv_oI); % oI\Inv_oI. 

  % Get the center and radii of the boxes of the one box nbhd.
  for j = 1: length(oI)
    coI(:,j) = b(1:d,oI(j));
    roI(:,j) = b(d+1:2*d,oI(j));
  end

  startintlab;
  d = tree.dim;
  % Map oI foward
  for k = 1:length(oI)
    c = coI(:,k);
    r = roI(:,k);
    int = infsup(c-r,c+r);
    [I] = interval_map(int);
    I_end = [];
    for k = 1:d
      I_end(k,1) = inf(I(k));
      I_end(k,2) = sup(I(k));
    end

	center = sum(I_end,2)/2;                % Center and radius of the image box.
	radius = abs(diff(I_end,1,2))/2;
	tree.insert_box(center,radius,depth);
  end

  % Find the invariant set again and return it
  n = zeros(1,tree.count(-1));
  for l = 1: length(Inv_oI)
    myInv = tree.search(cInv(:,l),depth);
    n(myInv) = 1;
  end

  Inv_oI = find(n);
