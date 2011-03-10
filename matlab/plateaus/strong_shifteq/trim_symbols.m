function S = trim_symbols(S)
  i = 1;
  while i <= length(S)
	if (isempty(S{i}))
	  S(i) = [];
	else
	  i = i+1;
	end	
  end
end
