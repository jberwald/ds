function [T comps shifteqs] = quick_contract(T,comps_final)
% function [T comps shifteqs] = quick_contract(T,comps_final)

%  curr_comps = num2cell(1:size(T,1));

  C = [];

  while true

	M = contraction_matrix(T);

	if (~any(any(M))) % nothing to contract
	  return
	end

	T = contract_edge(T,u,v);
	C = [C; u v forwardp];
	
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
