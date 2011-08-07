function Anew = cleanexitset(X,A,R,Adj)
% function Anew = cleanexitset(X,A,R,Adj)
  
  Anew = [];
  
  for r = 1 : length(R)
	thisA = intersect(A,onebox(R{r},Adj));
	thisR = get_regions(thisA,Adj);
	if length(thisR) > 2
	  [y i] = sort(cellfun(@(x) -length(x), thisR)); % sort by length descending
	  thisR = thisR(i);					% reorder thisR
	  toptwo = cat(2,thisR{1:2});
	else
	  toptwo = cat(2,thisR{:});
	end
	Anew = [Anew toptwo];				% save the biggest two only
  end
