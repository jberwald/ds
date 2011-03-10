function b = reductionExists(matcol,s,t,E,M,k)
% function b = reductionExists(matcol,s,t,E,M,k)
%   true iff there is some M2 in some C_{s,t,E2,k2} with:
%	k2 <= k, E containing E2, and M2 == M
%
%   note: we can say k2 <= k since there is a natural ordering of entries,
%   namely the order in which they are added
%
%   assumption: entries are in order of increasing k (check addMatrix)
%   actually, since we search all entries that have been added, don't need

  b = 0;								% innocent until proven guilty

  for entry = matcol.C{s,t}'			% convert to columns for the loop

%	if entry{3} > k						% see above for justification
%	  break;							% k increasing by assumption
%	end
	
	if (subset(entry{1}, E) && ismultiple(entry{2}, M))
	  b = 1;							% matches all conditions!
	  
%	  'reduction:'
%	  E
%	  entry{1}

	  break;
	end	
  end

