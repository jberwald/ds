function E = make_plateau_trees(plats,depths)

  tree = Tree('plateaus/zinarai.tree');
  load plateaus/repdat.mat
%  [reps R Adj] = pick_reps(tree);  
%  save plateaus/repdat.mat Adj R reps
  
  boxes = tree.boxes(-1);
  showraf(boxes','k','k');
  hold on
  
  E = {};
  for p = plats
%	showraf(boxes(:,R_plat{p})','y','g');	
%	plot(gca,inf(reps(p,1)),inf(reps(p,2)),'bo');
%	plot(gca,inf(reps(p,1)),inf(reps(p,2)),'k*');
	make_trees_param('henon',@henon_zin_image,depths,reps(p,:));
  end
  
  
  
