

function candidates = periodic_candidates(P, p)
  M = speye(size(P)) ~= 0;					% logical identity
  candidates = cell(1);
  for i = 1 : p;
	if (i == p)
	  candidates{i} = find(leandiag(M,(P~=0))); % don't bother computing M*P
	else
	  M = ((M*P) ~= 0);
	  candidates{i} = find(diag( M ))';
	end
    for k = 1 : (i-1)
	  if (rem(i,k) == 0)            
		candidates{i} = setdiff(candidates{i},candidates{k});            
	  end        
    end    
  end
end
