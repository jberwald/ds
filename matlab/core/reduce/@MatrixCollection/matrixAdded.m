function [matcol b] = matrixAdded(matcol)
% function [matcol b] = matrixAdded(matcol)
%   true if matrix was added since last call (or at all if first call)

  b = matcol.matrix_added;
  matcol.matrix_added = 0;
