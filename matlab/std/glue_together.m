
function V = glue_together(X,Y)
  V = [];
  for x = X
	for y = Y
	  V = [V; x y];
	end
  end
end
