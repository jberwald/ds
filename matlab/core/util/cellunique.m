function C = cellunique(C)
% function C = cellunique(C)
% C is a cell array of matrices
% returns the unique elements of C
% *** assumption: ***
% C is sorted such that if C(i) ~= C(i+1) then C(i) ~= C(j) for all j > i

i = 1;

while i <= length(C)
  j = i+1;
  while j <= length(C)
	if equal_elements(C{i},C{j})
	  C(j) = [];
	else
	  j = j+1;
	end
  end
  i = i+1;
end

end

function b=equal_elements(A,B)

b = (all(size(A)==size(B)) && all(all(A==B)));

end 
	
