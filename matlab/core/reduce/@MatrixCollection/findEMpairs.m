function EandM = findEMpairs(matcol,s,t,k)
% function EandM = findEMpairs(matcol,s,t,k)
%   find E,M such that M is a matrix for a s-t path of length k
%   return a cell array {E1 E2 E3...; M1 M2 M3...}

  C = matcol.C{s,t};
  if isempty(C)
	EandM = {};
  else
	boolvec = (cell2mat(C(:,3)) == k); 	% 1 at k-entry indices
	EandM = C(boolvec,1:2)';			% put in column format
  end
