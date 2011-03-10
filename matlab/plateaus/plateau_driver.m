function [E_plat IP_plat] = plateau_driver(plats,max_period)

  tree = Tree('plateaus/zinarai.tree');
%  load plateaus/repdat.mat
  [reps R_plat Adj_plat] = pick_reps(tree);  
  save plateaus/repdat.mat Adj_plat R_plat reps
  
  platboxes = tree.boxes(-1);
  clear tree;
  platpic = showraf(platboxes','m','r');
  hold on
  
  E_plat = cell(1,length(plats));
  IP_plat = cell(4,length(plats));
  depths = [16]; %:2:20];

  for p = 1 : length(plats)

	E = zeros(length(depths),max_period);
	max_ent = -1;

	for depth = depths
	  for period = 1:max_period
		[R G M SM X A I tree P Adj Z] = puff_driver('henon',depth, period, ...
													'params', reps(plats(p),:), ...
													'options', 'quiet');
		E(depth,period) = log_max_eig(SM);
		fprintf('plateau %i, depth %i, period %i: entropy = %3.4f\n', ...
				plats(p), depth, period, E(depth,period));

		if (E(depth,period) > max_ent)			% has to happen since ent >= 0
		  X_max = X;
		  A_max = A;
		  period_max = period;
		  depth_max = depth;
%%%		  boxes_max = tree.boxes(-1);
		end
	  end
	end
	
	IP_plat(:,plats(p)) = {X_max, A_max, depth_max, period_max};
	E_plat{plats(p)} = E;

%%%     h = figure;
%%% 	showraf(boxes_max(:,I_max)','c','c');
%%% 	showraf(boxes_max(:,A_max)','k','k');
%%% 	title(sprintf('plateau %i, depth %i, period %i: entropy = %3.4f', ...
%%% 				  plat, depth_max, period_max, max_ent));
%%% 	pause(0.5)
%%% 	savefig(sprintf('../images/plateau%i-depth%i-period%i', ...
%%% 					plat, depth_max, period_max), h, 'png','pdf');
%%% 	close(h);

%%% 	showraf(platboxes(:,R_plat{p})','y','g');	
%%% 	t = text(inf(reps(p,1)),inf(reps(p,2)),sprintf('%3.4f',max_ent));
%%% 	set(t,'FontUnits','points','FontSize',6);
%%% 	set(t,'HorizontalAlignment','center','BackgroundColor','w');

  end
  
  
  
