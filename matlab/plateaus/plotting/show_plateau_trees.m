function h = show_plateau_trees(plats,ents)

  tree = Tree('plateaus/zinarai.tree');

  load plateaus/repdat.mat
%  [reps R_plat Adj_plat] = pick_reps(tree);  
%  save plateaus/repdat.mat Adj_plat R_plat reps
  
  boxes = tree.boxes(-1);
  h = figure;

  axis ij

  set(gca,'xlim',[-1, 6.25]);
  set(gca,'ylim',[-1, 1]);
  set(gca,'layer','top');

  hold on

  if (nargin==1)
%	set(gca,'color',[0 0.7 1]);
	showraf(boxes','k','r');
  else
	set(gca,'color',[0 0.7 1]);
%	showraf_height(boxes',0,'k','k');
  end


  
  for i = 1 : length(plats)

	p = plats(i);

	if (nargin == 1)
%	  showraf(boxes(:,R_plat{p})','y','g');
	  t = text(inf(reps(p,1)),inf(reps(p,2)),1,sprintf('%i',i));
%	  t2 = text(inf(reps(p,1)),inf(reps(p,2)),-1,sprintf('%i',p));
	  set(t,'Color',[1 1 1])
%	  set(t,'FontWeight','bold');
 	  set(t,'FontUnits','points','FontSize',10);
	  set(t,'HorizontalAlignment','center','BackgroundColor','k');
%	  set(t2,'Color',[0 0.5 1])
%	  set(t2,'FontUnits','points','FontSize',6);
%	  set(t2,'HorizontalAlignment','center','BackgroundColor',[0 0.5 1]);


	else
%	  showraf_surf(boxes(:,R_plat{p})',ents(p),'y','none',0);
%	  showraf_height(boxes(:,R_plat{p})',ents(p), [ents(p)/max(ents) 0 0], 'none');

      colors = colormap;
	  c = ceil(ents(i)*length(colors)/max(ents));

	  showraf_height(boxes(:,R_plat{p})',ents(i), c, 'none');

% 	  set(gca,'xaxislocation','top');
% 	  set(gca,'cameraupvector',[1 0 0]);
% 	  set(gca,'dataaspectratio',[2.4972 1 1]); % match zin arai's paper

      if ents(i) == 0
		str = '0';
	  else
		str = sprintf('%0.2f', floor(100*ents(i))/100);
	  end

	  t = text(inf(reps(p,1)),inf(reps(p,2)),max(ents)+1, str); % round
%	  t2 = text(inf(reps(p,1)),inf(reps(p,2)),-1,sprintf('%0.2f',ents(p)));

	  if (abs(2*c/length(colors)-1) > 1/2)
		set(t,'Color','w')
%		set(t2,'Color',[0 0.7 1])
%		set(t2,'HorizontalAlignment','center','BackgroundColor',[0 0.7 1]);
	  else
		set(t,'Color','k')
%		set(t2,'Color','w')
%		set(t2,'HorizontalAlignment','center','BackgroundColor','w');
	  end
 	  set(t,'FontUnits','points','FontSize',6);
	  set(t,'HorizontalAlignment','center','BackgroundColor','none');
%	  set(t2,'FontUnits','points','FontSize',6);
	end


  end
  
  
  
