function sets = stronglyconnect(S,map,skinny)
% function sets = stronglyconnect(S,map [,skinny])
%
% add boxes to S to make map.P(S,S) strongly connected (if possible)
% more precisely, connect sink SCCs to the rest of the graph, or if no such
% connections are found, break it off into a new set (in sets{}) and continue
%
% skinny - 1 for skinny connections (default), 0 for fat
  
  if nargin < 3
    skinny = 1;
  end
  
  sets = {};

  %  fprintf('periodic boxes by period:')
  %  fprintf(' %d',cellfun(@length,C))
  %  fprintf('\n')
  
  while true
    S = grow_iso_raf(S,map.P,map.Adj);
    R = get_regions(S,map.Adj);
    T = contract_map(R,map.P);      % map on regions
    % map on sccs. comp(i):T->Tscc. inds{iscc} = old #'s
    [comps inds Tscc] = components_raf(T);
    fprintf('%d regions, %d region components\n',length(R),length(inds))
    if length(inds) == 1
      break % all connected up
    end

    % let's assume that the last component is a sink of the scc graph. so connect it
    % to the first (a source).  this assumption seems valid for the matlab_bgl
    % code (which just uses the standard dfs alg)
    i_sink = length(inds);
    sink = cat(2,R{inds{i_sink}}); % boxes in sink scc
    for i = 1:i_sink-1
      fprintf('testing connection %d -> %d\n',i_sink,i)
      src = cat(2,R{inds{i}}); % boxes in source scc
      conns = find_connections(sink,src,map.P,skinny);
      if ~isempty(conns)
        break
      end
    end
    
    if isempty(conns) % we found a true sink, so cut it off and keep going
      sets{end+1} = S;
      S = setdiff(S,sink);
      fprintf('saved sink and removed regions\n')
    else
      fprintf('adding %d connection boxes\n',length(conns))
    end
    S = union(S,conns);
  end
  sets{end+1} = S;
