function b = set_equal(A,B)
% function b = set_equal(A,B)
  uA = unique(A(:));
  uB = unique(B(:));

  if (length(uA)==length(uB))
	b = all(uA==uB);
  else
	b = logical(0);
  end
end
