function S = remove_preimages(tree, P, Adj, mapname, depth, num_preimages)
% function S = remove_preimages(tree, P, Adj, mapname, depth, num_preimages)

%  prefix = sprintf('topdata/%s_remove_gap_%d',mapname,depth);
%  matfile = [prefix '.mat'];

  % check whether the files exist... 
%  if (unix(['ls ' matfile]) == 0)
%	load(matfile);
%  else

%    gap_center = [1.2725; -.012];
%    gap_radius = [.02; .015];
	gap_center = [1.2717; -0.0207];
    gap_radius = [.02; .001];
    
	tree.count(-1);
    gap = tree.search_box(gap_center, gap_radius);
    
%	save(matfile,'gap');
%  end
  
  boxes = tree.boxes(-1);
  
  prev_image = gap;
  X = gap;
	
  for i = 1 : num_preimages
	prev_image = find(any(P(prev_image,:),1)); % preimage of the last image
	X = union(X, prev_image);
	
%	figure
%	plotb(tree,[1 2],'g');
%	show2(boxes(:,X)','b');
  end
  
  X = onebox(X, Adj);
  
  S = setdiff(1:size(P,1), X);
  
