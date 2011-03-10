%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% lefschetz_path
%
% function [tr A] = lefschetz_path(path,M,G)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [tr A] = lefschetz_path(path,M,G)
  A = 1;
  for i = 1 : length(path)-1
	A = M(G{path(i+1)},G{path(i)}) * A;
  end
  tr = trace(A);
end
