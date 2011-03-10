function h = plot_plat_nums(ents)

  load good_plats
  plats = good_plats;
  tree = Tree('plateaus/zinarai.tree');
  load plateaus/repdat.mat
  boxes = tree.boxes(-1);

  h = figure;
  axis ij
  set(gca,'xlim',[-1, 6.25]);
  set(gca,'ylim',[-1, 1]);
  set(gca,'layer','top');
  hold on
  if nargin < 1
	showraf(boxes','k','r');
  end

  for i = 1 : length(plats)

	p = plats(i);

	aval = inf(reps(p,1));
	bval = inf(reps(p,2));
	if bval > 0.98
	  bval = 0.98;						% make 18, 39 more readable
	end

	if nargin < 1

	  t = text(aval, bval, 1, sprintf('%i',i));
	  set(t,'Color',[1 1 1])
	  set(t,'FontUnits','points','FontSize',10);
	  set(t,'HorizontalAlignment','center');
	  set(t,'BackgroundColor','k','Margin',0.5);

	else

      colors = colormap;
	  c = ceil(ents(i)*length(colors)/max(ents));

	  showraf_height(boxes(:,R_plat{p})',ents(i), c, 'none');

      if ents(i) == 0
		str = '0';
	  else
		str = sprintf('%0.2f', floor(100*ents(i))/100);
	  end

	  t = text(aval, bval, max(ents)+1, str); % round

	  set(t,'Color','k')
 	  set(t,'FontUnits','points','FontSize',6);
	  set(t,'HorizontalAlignment','center');
	  set(t,'BackgroundColor',[0.7 0.9 1],'Margin',0.2);
	end

  end

  opts = struct('FontMode','fixed','FontSize',8,'height',8,'Color','rgb');
  if nargin < 1
	exportfig(gcf, 'plateau-nums.eps', opts);
  else
	exportfig(gcf, 'plateau-ents-flat.eps', opts, 'FontSize', 7);
  end  
  
