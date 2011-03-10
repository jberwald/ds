function mosthomologicallyinterestingregion(map,R,G,A)
% mosthomologicallyinterestingregion(map,R,G,A)
% mosthomologicallyinterestingregion(map,dat)
    
  if nargin == 2
    A = R.A;
    G = R.G;
    R = R.R;
  end

  for i = 1:length(G)
  
	if all(cellfun(@isempty,G{i}))
	  continue;
	end

	[gen_num r_max] = max(cellfun(@length,G{i}));
  
	figure
	set(gcf,'name',sprintf(['Most Homologically Interesting Region' ...
					' (%d generators)'],gen_num));
  
	boxes = map.tree.boxes(-1);
	show2(boxes(:,R{r_max})','c');
	show2(boxes(:,intersect(A,onebox(R{r_max},map.Adj)))','k');

  end
