function S = pairwise_connect(C,v,P,skinny)

  if nargin >= 4 && skinny
	S = pairwise_skinny_connect(C,v,P);
	return
  end

  S = cat(2,C{v});
 
  for j = 1 : length(v)
	for k = j+1 : length(v)

	  S_jk = find_connections(C{v(j)},C{v(k)},P);
	  S_kj = find_connections(C{v(k)},C{v(j)},P);

	  S = union(S,union(S_jk,S_kj));

	end
  end

end
