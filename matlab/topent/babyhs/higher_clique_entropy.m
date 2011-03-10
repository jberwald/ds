function b = higher_clique_entropy(clique,entropy,E)


  b = 0;								% default: no
  for c = 1:size(E,1)
	
	if (E{c,2} < entropy && subset(E{c,1}, clique))
	  b = 1;							% witness to an entropy increase
	  return
	end

  end

end
