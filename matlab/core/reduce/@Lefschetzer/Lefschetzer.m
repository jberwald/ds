function lef = Lefschetzer(M,G)
% function lef = Lefschetzer(M,G)
% M - index map
% G - generator cell array


  if nargin == 0
    lef.M = [];
    lef.G = {};
    lef.monogen = [];
    lef.polygen = [];
    lef.SM = [];
    lef.SMpolygen = [];
	lef.n = 0;
    lef.matcol = [];
    lef.bad_edge_sets = {};
  else
	lef.n = length(G);
    lef.M = M;
    lef.G = G;
    lef.SM = contract_map(G,M); % map on regions according to the index map
	lef.monogen = find(cellfun(@length,G) == 1); % one gen / region
    lef.polygen = find(cellfun(@length,G) > 1);  % many gens / region

	lef.SMpolygen = sparse(lef.n,lef.n);
	lef.SMpolygen(lef.polygen,lef.polygen) ...
		= lef.SM(lef.polygen, lef.polygen);

	lef.matcol = MatrixCollection(lef.n);
    lef.bad_edge_sets = {};
  end

  lef = class(lef,'Lefschetzer');


