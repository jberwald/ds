function [C_T C_D] = exhaustive_contract_quick(T,D)
% function [C_T C_C] = exhaustive_contract_quick(T)

  M = contraction_matrix(T);
  C_T = {};
  C_D = {};

  if (~any(any(M))) % nothing to contract
	C_T = {T};
	C_D = {D};
	return
  end

  [i j] = find(M);
  for edge = 1 : length(i)
	u = i(edge);
	v = j(edge);
	
	[C_T2 C_D2] = exhaustive_contract_quick(contract_edge(T,u,v), ... % new T
											[D; u v M(u,v)>0]); % edge, direction of rule
	C_T = {C_T{:} C_T2{:}};
	C_D = {C_D{:} C_D2{:}};
  end
end

function T = contract_edge(T,u,v)
% precond: u < v
  preimgv = mapimage(T,v);
  imgv = mapimage(T,v);
  T(u,preimgv) = 1;
  T(imgv,u) = 1;
  T(v:end-1,:) = T(v+1:end,:);
  T(:,v:end-1) = T(:,v+1:end);
  T = T(1:end-1,1:end-1);
end

function M = contraction_matrix(T)

  n = size(T,1);
  M = sparse(n,n);

  for i = n-1 : -1 : 1
	for j = n : -1 : i+1

	  [contractp forwardp] = can_contract(T,i,j);
	  M(i,j) = 2*forwardp - 1;			% 1 if forward, -1 if backward
	  
	end	  
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
