
function matcol = MatrixCollection(n)
% MatrixCollection
%  
% This class is a container for paths, and the corresponding index map
% composition along the paths.  Each path is indexed by the endpoints (s,t),
% and in each of these (s,t) "buckets" is a list of entries {E,M,k}, which
% correspond to an s-t path of length k, using exactly the edges in E, and
% whose index map matrix composition is M.
%
% Note that the actual path p is never actually stored explicitly (and even
% implicitly, since the same {s,t,E,M,k} tuple could be generated from multiple
% paths in general), but this is simply because we'll never need the actual
% path.
%
% Variables:
% n - is the number of vertices
% C - cell matrix of {E,M,k} entries, indexed by {s,t}
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
  

