function plot_goodplats(E,printp)

  if nargin < 2
	printp = 0;
  end

  ommit_list = find(max(E')==0);
  keep_list = setdiff(1:size(E,1), ommit_list);

  splitplot2d([7 5], @(v,s) plot_one(v,s,E,keep_list), 0.08, [0.01 0.06]);

  if printp
    opts = struct('FontMode','fixed','FontSize',12,'height',8, ...
				  'LockAxes', 0);
    exportfig(gcf, 'plot_goodplats.eps', opts, 'Color', 'rgb');
%	print -depsc plot_goodplats_print.eps
  end

end


function plot_one(pos, siz, E, keep_list)
  % keep list is the indices to draw
  % number the grid squares left-right top-bottom
  gridnum = siz(1)*(siz(2)-pos(2)) + pos(1);

  if (gridnum <= length(keep_list))
	platnum = keep_list(gridnum);
	plot([1 size(E,2)], repmat(max(E(platnum,:)),1,2), 'r', ...
		 1:size(E,2), E(platnum,:), 'b')

	% labels
	xlabel(sprintf('%d:  %1.4f',platnum,max(E(platnum,:))));
	set(gca,'xticklabel','');
	set(gca,'xlim',[1 size(E,2)]);
	set(gca,'ylim',[0 0.75]);
	set(gca,'ytick',[0 0.2 0.4 0.6])
	if pos(1) > 1
	  set(gca,'yticklabel','')			% only print labels on left side
	end

	% grid: draw everything in gray and then redraw numbers + axes in black
	set(gca,'xgrid','on','ygrid','on')
	set(gca, 'xcolor', [0.5 0.5 0.5], 'ycolor', [0.5 0.5 0.5]);
	c_axes = copyobj(gca,gcf);
	set(c_axes, 'color', 'none', 'xcolor', 'k', 'xgrid', 'off', 'ycolor','k', 'ygrid','off');
  else									% extra grid spaces
	set(gca,'visible','off')
  end
end
