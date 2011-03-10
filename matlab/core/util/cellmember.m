function b = cellmember(elt,C)
% function b = cellmember(elt,C)
% C is a cell array of matrices
% returns true iff 'elt' is in C
% *** assumption: ***

b = any(cellfun(@(x) equal_elements(elt,x), C));

end

function b=equal_elements(A,B)

b = (all(size(A)==size(B)) && all(all(A==B)));

end 
	
