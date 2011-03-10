function [T comps shifteqs] = distance_contract(T,R,boxes)
% function [T comps shifteqs] = distance_contract(T,R,boxes)

  if (nargin < 4)
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
  D = distance_matrix(R,boxes);
size(D)

  while true
	[T comps R S C] = contract_one_distance(T,D,comps,C);

	if (isempty(S))						% didn't contract
	  return
	end

	shifteqs(end+1,1:2) = {R S};
  end
