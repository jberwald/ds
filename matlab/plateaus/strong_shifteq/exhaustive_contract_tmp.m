function [M C] = exhaustive_contract(T)
% find matrices SSE (strongly shift-equivalent) to T by contraction
%
% M - cell array with n=size(1,T) rows
%     row r is a list of all size-r matrices obtained from T
%
% C - cell array with n-1 rows
%     element e of row r is a matrix of the form [u1 v1 k1; u2 v2 k2; ... ]
%     where element ki of row r+1 of M is obtained by contracting ui and vi
%       of element e of row r of M
%
% The algorithm is to perform DFS (with respect to a fixed ordering of vertex
% pairs), but stop whenever an element is already in M, since we must have
% already computed that element's children.

n = size(T,1);
M = cellrow(n);
C = cellrow(n-1);

M{1} = {T}
C{1} = {[]}



[M C] = process(1,1,M,C,[],[]);

end

function [M C] = process(row,elt,M,C,E,pair)

%  fprintf('process(%i,%i,M,C)\n',row,elt)

  if (row == length(M))					% row == n
	return
  end

  A = M{row}{elt};
  E = get_vertex_pairs(A,E,pair);

  for e = E								% e is a column vector

	comps = num2cell(1:size(A,1));
	comps{e(1)} = e;
	comps(e(2)) = [];					% kill entry
	B = contract_map(comps,A);

	if (~cellmember(B,M{row+1})) % pruning: skip if we've already computed children
	  newelt = length(C{row+1})+1;
%	  fprintf('adding new element (%i,%i)\n',row,newelt)
	  C{row+1}{newelt} = [];
	  M{row+1}{newelt} = B;
	  C{row}{elt} = [C{row}{elt}; e' newelt];
	  [M C] = process(row+1, newelt, M, C, E, e);
	else
%	  disp('already in list')
	end
	
  end
end

function E = get_vertex_pairs(A,E,pair)
% S = vertices possibly effected by contracting pair to pair(1)

  if (isempty(E))
	S = 1 : size(A,1);
  else
	E(E==pair(2)) = pair(1);			% pair(2) is now pair(1)
	E(E>pair(2)) = E(E>pair(2)) - 1;	% anything higher that pair(2) is now 1 lower
	S = union(mapimage(A,pair(1)),mapimage(A',pair(1))); % sorted
	S = union(S, pair(1));					% sorted
	good_entries = all(~ismember(E,S));
	E = E(:,good_entries);
  end

  for i = 1 : size(A,1)
	for j = S(S > i)
	  if (can_contract(A,i,j))
		E = [E [i;j]];
	  end
	end	
  end

end

function C=cellrow(k)

  C = cellfun(@num2cell,cell(1,k),'uniformoutput',0);

end
