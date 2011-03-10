function [B C map] = pp_raf(map, period, depth, B)

% pp_raf - periodic points.
%   [B C] = pp_raf(map, period, depth [, B])
%   computation of the set of periodic points of a certain period
% map - the map object at the starting depth
% period - the maximum period to consider
% depth - the /final/ depth, where orbits are desired
% B (optional) - a starting set of candidate boxes
%

to_be_subdivided = 8;

mapname = map.name;
if nargin < 4
  C = periodic_candidates(map.P,period);
  B = sets2boxes(C,map.tree.boxes(-1));
else
  C = boxes2sets(B,map.tree);
end

for d = map.depth+1 : depth

  % move to depth d, saving only the candidate boxes
  map.depth = d;
  map = update_prefix(map);
  if exist([map.prefix '.mat']) % already have the map
    map = get_map(mapname,d,'params',map.params);
  else % no map stored at depth d, so proceed without one!
    fprintf('warning: no map at depth %i, so box numbers will be off\n',d);
    S = cat(2,C{:});
    map.tree = crop_tree(map.tree,S);
    if (map.tree.depth == 0)
      disp(sprintf('No candidates remain at depth %d.',d))
      return;
    end
    for i = 1 : map.tree.dim
      map.tree.set_flags('all', to_be_subdivided);
      map.tree.subdivide;
    end
    % compute the map
    map.P = rigorous_matrix(map);
  end

  % recover candidate boxes
  map.tree.count(-1); % for the searching
  C = boxes2sets(B,map.tree);

  % refine candidates for this depth
  for k = 1:period
    if isempty(C{k}), continue, end
    %	fprintf('d = %i, k = %i\n',d,k)
    A = map.P(C{k},C{k});
    C{k} = C{k}(find(leandiag(A,leanmult(A,k-1))));
%    C{k} = C{k}(find(diag(leanmult(map.P(C{k},C{k}),k))));
%    C{k} = C{k}(find(diag(mpower2(full(map.P(C{k},C{k})),k))));
    % optional and possibly destructive: weed out divisors
%     for i = 1 : (k-1)
% 	  if (rem(k,i) == 0)
% 		C{k} = setdiff(C{k},C{i});
%       end
%     end    
  end

  % save candidate boxes
  B = sets2boxes(C,map.tree.boxes(-1));
  
  fprintf('depth %i:', d)
  fprintf(' %i', cellfun(@length,C))
  fprintf('\n')
end

end

function B = sets2boxes(C,boxes)
  B = {};
  for i = 1:length(C)
    B{i} = boxes(:,C{i});
  end
end

function C = boxes2sets(B,tree)
  d = tree.dim;
  C = {};
  for i = 1:length(B)
    C{i} = {};
    for j = 1:size(B{i},2)
      C{i}{j} = tree.search_box(B{i}(1:d,j),B{i}(d+1:2*d,j));
      C{i}{j} = C{i}{j}(C{i}{j} > 0);      
    end
    C{i} = unique(cat(1,C{i}{:}))';
  end
end

