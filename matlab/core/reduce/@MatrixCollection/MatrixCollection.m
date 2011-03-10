
function matcol = MatrixCollection(n)
% function matcol = MatrixCollection(n)
% n is the number of vertices
% cell matrix of {E,M,k} entries, indexed by {s,t}
% E - edge set for the implicit path p
% M - matrix corresponding to p in the index map
% k - the length of p

  matcol.n = n;
  matcol.C = cell(n,n);
  for i=1:n
	for j=1:n
	  matcol.C{i,j} = {};
	end
  end

  matcol.matrix_added = 0;

  matcol = class(matcol,'MatrixCollection');
  

