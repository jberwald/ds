function EandM = getEMpairs(matcol,s,t)
% function EandM = getEMpairs(matcol,s,t)
%   retrieves all matrices + edge sets in {s,t} entry

  C = matcol.C{s,t};
  if isempty(C)
	EandM = {};
  else
	EandM = C(:,1:2)';					% row cell for looping
  end
