function [T_new comps R S comps_f] = contract_one(T,comps,comps_f)

  i = 0;
  j = 0;
  T_new = T;
  S = [];
  R = [];

  for i = 1 : length(comps)
	for j = i+1 : length(comps)

	  if (comps_f{i} == comps_f{j} ...
		  && can_contract(T,i,j))

%		fprintf('contracting %i and %i\n',i,j);

		comps_one = num2cell(1 : size(T,1)); % symbol list
		comps_one{i} = [i j];				% combine i and j to i
		comps_one(j) = [];
		T_new = contract_map(comps_one,T);

		comps{i} = union(comps{i},comps{j});		% original symbols
		comps(j) = [];
		comps_f(j) = [];

%		%%% HACK to speed up:
%		S = 1;

		if (forward_rule(T,i,j))
		  [R S] = elementary_shifteq(T,i,j);
		else
		  % use T' instead, and reverse S,R and transpose them
		  [S R] = elementary_shifteq(T',i,j);
		  R = R';			% transpose to get correct matrices
		  S = S';
		end

		return

	  end
	  
	end	  
  end

  i = 0;
  j = 0;

end

