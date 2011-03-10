function [E_plat] = plateau_babyhs(plats,max_period)

  tree = Tree('plateaus/zinarai.tree');
%  load plateaus/repdat.mat
  [reps R_plat Adj_plat] = pick_reps(tree);  
  save plateaus/repdat.mat Adj_plat R_plat reps
  
  E_plat = zeros(1,length(plats));

  for p = 1 : length(plats)

	[max_ent sets tree P Adj I] ...
		= babyhs('henon', 16, max_period, 'params', reps(plats(p),:));
	E(p) = max_ent;
	fprintf('plateau %i: entropy = %3.4f\n', plats(p), E(p));

  end
  
  
  
