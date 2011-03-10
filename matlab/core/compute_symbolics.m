function d = compute_symbolics(S,map,options)
% data = compute_symbolics(S,map,options)
%
% components of data:
%   R - the disjoint regions of the invariant set
%   G - cell array of mappings from regions to generators
%   M - the index maps
%   SM - the computed subshift
%   (X,A) - the index pair
%   I - the invariant set (I = X / A)
%   hmax - the highest entropy lower bound obtained
%   hvec - all the entropy bounds (one for each homology level)
%   G_inv, M_inv - the generators and index map after processing
%   idstr - a unique id if you want to recover the actual homcubes output
%
% options:
%   quiet - no status output or images
%   entropy - just want positive entropy, so bail if it's not going to work out

  status = 1;							% display text output
  justentropy = 0;                      % only care about the entropy
  
  if (nargin > 2)
	if (isfield(options, 'quiet'))
	  status = 0;
	end
	if (isfield(options, 'justentropy'))
	  justentropy = options.justentropy;
	end
  else
	options = '';	% options progogate to other funcs (e.g. reduce)
  end

  % default return values:
  d = struct;
  d.hmax = 0;
  
  if (isempty(map.P))
    error('Empty transition matrix')
  end	

  if (status), fprintf('growing isolated invariant set...'), end
  d.I = grow_iso_raf(S, map.P, map.Adj); 	% Growing an isolating neighborhood for S.
  if (status), fprintf(' %d boxes total\n',length(d.I)), end

  if (status), fprintf('building index pair...'), end
  [d.X d.A] = build_ip_raf(d.I, map.P, map.Adj);		% Constructing an index pair (X, A).
  if (status), fprintf('\n'), end

  if (isempty(map.Adj)) % || set_equal(X,1:map.tree.count(-1)))
    error('Empty adjacency matrix')
  end

  if (status), fprintf('finding connected regions...'), end
  d.R = get_regions(setdiff(d.X,d.A),map.Adj);
  if (status), fprintf(' %d regions found\n',length(d.R)), end

  if (isempty(d.R))
    error('No regions found')
  end	
  
  if (justentropy && length(d.R)<=1)
    if status, disp('not enough regions for entropy, aborting'), end
    return
  end
  
  if (status), fprintf('computing index map...'), end
  [d.M d.G d.idstr] = index_map(d.X, d.A, d.I, d.R, map);
  if (isempty(d.M))
    if (status), disp('trivial homology; aborting'), end
    return
  end
  if (status)
	v = cellfun(@(m) size(m,1), d.M);
	fprintf(' {');
	fprintf('%d, ', v(1:end-1));
	fprintf('%d}', v(end));
	fprintf(' generators total (%s)\n',d.idstr);
  end

  d.SM = {};
  d.M_inv = {};
  d.G_inv = {};

  for i = 1:length(d.M)
  
	if (isempty(d.M{i}))
      d.SM{i} = [];
	  continue;
	end

	if (status), fprintf('reducing index map...'), end
	[sm m_inv g_inv] = reduce_index_map(d.M{i}, d.G{i}, 0, options);
	d.SM{i} = sm;
	d.M_inv{i} = m_inv;
	d.G_inv{i} = g_inv;

	% debug
	
    %if (~isempty(d.M))
    %  boxes = map.tree.boxes(-1);
	%  validate_index_map(d.R,d.G{i},d.M{i},map.P,boxes);
	%  check_symbol_map(d.SM{i},d.M{i},d.G{i},0); %  check_symbol_map(sm,M,G,1);
	%end

	% end debug

  end

  entropies = cellfun(@log_max_eig,d.SM);     % the entropy lower bounds
  if (status)
    fprintf(' entropy =')
	fprintf(' {');
	fprintf('%.4f, ', entropies(1:end-1));
	fprintf('%.4f}', entropies(end));
    fprintf('\n')
  end
	
  d.hmax = max(entropies);
  d.hvec = entropies;
end
