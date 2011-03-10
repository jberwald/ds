function [R G M SM X A I Z] = compute_symbolics(S,tree,mapname,P,Adj,options)
% function [data] = compute_symbolics(S,map,options)
% depreciated: function [R G M SM X A I Z] = compute_symbolics(S,tree,mapname,P,Adj,options)
% Z = {G_inv M_inv idstr}
%
% options:
%   quiet - no status output or images
%   noims - status output but no images

  if (nargin <= 3)
	map = tree;
	
	if (nargin == 3)
	  options = mapname;
	else
	  options = '';
	end
  else
	%%%% HACK for backwards compatability
	map = struct;
	map.tree = tree;
	map.name = mapname;
	map.P = P;
	map.Adj = Adj;
	map.space = 'Rn';
  end

  status = 1;							% display text output
  images = 0;							% display images
  justip = 1;							% only show the index pair image
  matrices = 0;							% output latex matrices for M, SM, etc
  growiso = 1;							% perform grow_iso (set not already isolated)

  if (nargin >= 6)
	if (strmember('quiet', options))
	  status = 0;
	  images = 0;
	  justip = 0;
	end
	if (strmember('noims', options))
	  status = 1;
	  images = 0;
	  justip = 0;
	end
	if (strmember('allims', options))
	  status = 1;
	  images = 1;
	end
	if (strmember('justip', options))
	  status = 1;
	  images = 0;
	  justip = 1;
	end
	if (strmember('matrices', options))
	  matrices = 1; % deprecated
	end
	if (strmember('nogrowiso', options))
	  growiso = 0;
	end
  end

  % default return values:
  R = {};
  G = {};
  M = [];
  SM = [0];
  X = [];
  A = [];
  I = [];
  Z = {0 0 0 0 0 0 0};
  
  if (isempty(map.P))
	return
  end	

  if growiso
	if (status), fprintf('growing isolated invariant set...'), end
	I = grow_iso_raf(S, map.P, map.Adj); 	% Growing an isolating neighborhood for S.
	if (status), fprintf(' %d boxes total\n',length(I)), end
  end

  if (status), fprintf('building index pair...'), end
  [X, A] = build_ip_raf(I, map.P, map.Adj);		% Constructing an index pair (X, A).
  if (status), fprintf('\n'), end

  if (isempty(map.Adj)) % || set_equal(X,1:map.tree.count(-1)))
	return
  end

  if (status), fprintf('finding connected regions...'), end
  R = get_regions(setdiff(X,A),map.Adj);
  if (status), fprintf(' %d regions found\n',length(R)), end

  if (isempty(R))
	return
  end	
  
  boxes = map.tree.boxes(-1);
	
  if (images || justip)
	figure
	set(gcf,'name','Index Pair');
	if (map.tree.depth <= 14)
	  show2(boxes(:,X)','c');
	  show2(boxes(:,A)','b');
	else
	  showraf(boxes(:,X)','c','c');
	  showraf(boxes(:,A)','k','k');
	end  
  end
	
  if (status), fprintf('computing index map...'), end
  [M G idstr] = index_map(X, A, I, R, map);
  if (isempty(M)), disp('trivial homology; aborting'), return, end
  if (status)
	v = cellfun(@(m) size(m,1), M);
	fprintf(' {');
	fprintf('%d, ', v(1:end-1));
	fprintf('%d}', v(end));
	fprintf(' generators total (%s)\n',idstr);
  end

  SM = {};
  M_inv = {};
  G_inv = {};

  for i = 1:length(M)
  
	if (isempty(M{i}))
	  continue;
	end

	if (images)
	  figure
	  [gen_num r_max] = max(cellfun(@length,G{i}));
	  set(gcf,'name',sprintf(['Most Homologically Interesting Region' ...
					' (%d generators)'],gen_num));
	  show2(boxes(:,R{r_max})','c');
	  show2(boxes(:,intersect(A,onebox(R{r_max},map.Adj)))','k');
	end

	if (status), fprintf('reducing index map...'), end
	[sm m_inv g_inv] = reduce_index_map(M{i}, G{i}, 0, options);
	SM{i} = sm;
	M_inv{i} = m_inv;
	G_inv{i} = g_inv;

	if (status), fprintf(' entropy = %f\n',log_max_eig(SM{i})), end

	if (images)
	  figure
	  SM_I = graph_mis(SM);
	  symbol_boxes = cat(2,R{SM_I});
	  set(gcf,'name','Symbol Regions');
	  % show2(boxes','g');
	  show2(boxes(:,symbol_boxes)','b');
	end
	
	% debug
	
	if (~isempty(M))
	  validate_index_map(R,G{i},M{i},map.P,boxes);
	  check_symbol_map(SM{i},M{i},G{i},0); %  check_symbol_map(sm,M,G,1);
	end

	% end debug

  end

  if nargout == 1
	data = struct;
	data.R = R;
	data.G = G;
	data.M = M;
	data.SM = SM;
	data.X = X;
	data.A = A;
	data.I = I;
	data.G_inv = G_inv;
	data.M_inv = M_inv;
	data.idstr = idstr;
	R = data;
  else
	Z = {G_inv M_inv idstr};
  end
end
