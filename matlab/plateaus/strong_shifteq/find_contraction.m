function [T comps shifteqs] = find_contraction(T,comps_final)
% function [T comps shifteqs] = find_contraction(T,comps_final)

  if (nargin == 1)

	C = num2cell(ones(1,size(T,1))); 	% desired final components

  else

	C = zeros(1,size(T,1));
	for n = 1:length(comps_final)
	  C(comps_final{n}) = n;
	end
	C = num2cell(C); 					% desired final components

  end

  comps = num2cell(1 : size(T,1));		% current components
  shifteqs = {};

  while true

	[T comps R S C] = contract_one(T,comps,C);

	if (isempty(S))						% didn't contract
	  return
	end

	shifteqs(end+1,1:2) = {R S};
	
  end

end



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
