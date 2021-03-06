function C = pp_map(map, period, depth)

% pp_map - periodic points using pre-computed maps.
%   C = pp_map(map, period, depth)
%   computation of the set of periodic points of a certain period. 

mapname = map.name
C = periodic_candidates(map.P,period)
B = sets2boxes(C,map.tree.boxes(-1));

for d = map.depth+1 : depth
  map = get_map(mapname,d);
  map.tree.count(-1); % for the searching
  C = boxes2sets(B,map.tree);
  for k = 1:period
    C{k} = C{k}(find(diag(leanmult(map.P(C{k},C{k}),k))));
    for i = 1 : (k-1)
	  if (rem(k,i) == 0)
		C{k} = setdiff(C{k},C{i});
      end
    end    
  end
  B = sets2boxes(C,map.tree.boxes(-1));
  fprintf('depth %i:', d)
  fprintf(' %i', cellfun(@length,C))
  fprintf('\n')
  %  pause,close
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

