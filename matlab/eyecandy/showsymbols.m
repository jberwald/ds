function H = showsymbols(boxes, R, syms, colvec, ecolvec)
% H = showsymbols(boxes, R, syms, col, ecol)
% H = showsymbols(map, dat)
%
% NOTE: assumes everything is 2d
%
% I_R = graph_mis(SM);
% SM = SM(I_R,I_R); %get rid of transient / rejected symbols
% showsymbols(boxes,R(I_R),1:length(I_R),'k','none');

  if nargin == 2
	map = boxes;
	dat = R;

	boxes = map.tree.boxes(-1);

	[sz homology_level] = max(cellfun(@(x) prod(size(x)), dat.SM));
	syms = graph_mis(dat.SM{homology_level});
	R = dat.R(syms);

	colvec = 'k';
	ecolvec = 'none';
  end
	

  if (size(colvec,1) == 1)
	colvec = repmat(colvec,length(syms),1);
  end
  if (size(ecolvec,1) == 1)
	ecolvec = repmat(ecolvec,length(syms),1);
  end

  H = [];

  for r = 1:length(syms)
	[x y] = find_center(boxes,R{r});
	if (max(syms) > 26)
	  h = text(x,y,sprintf('%d',syms(r)));
	else
	  h = text(x,y,char('A'+syms(r)-1));
	end
	set(h,'Color',colvec(r,:)','EdgeColor',ecolvec(r,:)')
	set(h,'FontWeight','bold');
%	set(h,'FontUnits','points','FontSize',6);
	set(h,'HorizontalAlignment','center','BackgroundColor',ecolvec(r,:)');
	H(end+1) = h;
  end
end

function [x y] = find_center(boxes,S)
  x_min = min(boxes(1,S));
  x_max = max(boxes(1,S));
  x = (x_min + x_max) / 2;				% midpoint of the x
  y = mean(boxes(2,S));					% average y
end
