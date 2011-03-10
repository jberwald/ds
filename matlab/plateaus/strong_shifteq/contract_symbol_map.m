function T = contract_symbol_map(T,S_final)

  C = zeros(1,size(T,1));
  for n = 1:length(S_final)
	C(S_final{n}) = n;
  end
  C = num2cell(C);

  S = num2cell(1 : size(T,1)); 			% symbol list
  SS = {};
 
  while (length(SS) ~= length(S))
	SS = S;
	for n = 1:length(S_final)
	  [T S C] = contract_symbol(T,S,C,n);
	end
  end

  if (length(C) == length(S_final))
	cell2mat(C)
	p = inv_perm(cell2mat(C),length(C)) % reorder symbols
	T = T(p,p);
  end

end


function [T S C] = contract_symbol(T,S,C,n)

  SS = {};

  while (length(SS)~=length(S))
	SS = S;
	[T S C] = contract_symbol_one(T,S,C,n);
  end
  
end


function [T S C] = contract_symbol_one(T,S,C,n)
% C: cell array mapping symbols to eventual symbol #'s
% S: cell array containing the regions for each current symbol
% T: current transition matrix

  A = find(cell2mat(C)==n);
%  A = A(randperm(length(A)))

  for i = 1 : length(A)
	for j = i+1 : length(A)
	  
	  if (can_contract(T,A(i),A(j)))

%		fprintf('contracting %i and %i\n',A(i),A(j));

		S_one = num2cell(1 : size(T,1)); % symbol list
		S_one{A(i)} = [A(i) A(j)];
		S_one(A(j)) = [];
		T = contract_map(S_one,T);

		S{A(i)} = union(S{A(i)},S{A(j)});		% original symbols
		S(A(j)) = [];
		
		C(A(j)) = [];

		return

	  end
	  
	end	  
  end

end

