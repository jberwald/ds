function [E IP] = plateau_driver_wholetree(plats,depths)

  tree = Tree('plateaus/zinarai.tree');
  load plateaus/repdat.mat
%  [reps R_plat Adj_plat] = pick_reps(tree);  
%  save plateaus/repdat.mat Adj_plat R_plat reps
  
  platboxes = tree.boxes(-1);
  clear tree;
  platpic = showraf(platboxes','m','r');
  hold on
  
  E = zeros(length(plats),length(depths));
  IP = cell(length(plats),length(depths));

  for p = 1 : length(plats)

	for depth = 1:length(depths)

	  [tree P Adj] = get_map('henon',depths(depth),{'params',reps(plats(p),:)});
	  boxes = tree.boxes(-1);
	  [R G M SM X A I Z] = compute_symbolics(1:size(boxes,2),tree,'henon',P,Adj);

	  IP{p,depth} = {X, A};
	  E(p,depth) = log_max_eig(SM);

	  fprintf('plateau %i, depth %i: entropy = %3.4f\n', ...
			  plats(p), depths(depth), E(p,depth));

	end

  end

end
  
  
  
