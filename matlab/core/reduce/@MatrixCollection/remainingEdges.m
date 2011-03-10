function B = remainingEdges(matcol,k)
% function B = remainingEdges(matcol,k)
%   retrieves all edge sets that have not yet been reduced at step k
%   we will just assume these are bad since we have not verified them

  B = {};

  for s = 1:matcol.n
	for t = 1:matcol.n
	  C = matcol.C{s,t};
	  if isempty(C)
		continue						% nothing to add
	  end
	  boolvec = (cell2mat(C(:,3)) == k); 	% 1 at k-entry indices
	  C = C(boolvec,1);					% edge sets
	  B(end+1:end+length(C)) = C;		% add C
	end	
  end
