%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% ismultiple
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function b = ismultiple(A,B)
  b = 0;
  if (spones(A) == spones(B))
	[i j] = find(A);
	if (length(i)==0)						% both 0 matrix
	  b = 1;
	  return;
	end
	c = A(i(1),j(1)) / B(i(1),j(1));
	if (A == c * B)
	  b = 1;
	end
  end
end
