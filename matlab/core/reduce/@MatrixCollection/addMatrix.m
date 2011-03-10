function matcol = addMatrix(matcol,s,t,E,M,k)
% function matcol = addMatrix(matcol,s,t,E,M,k)
%   add the corresponding entry
%   numeric ids used for edges

  entry = size(matcol.C{s,t},1)+1;
  matcol.C{s,t}(entry,1:3) = {E,M,k};
  matcol.matrix_added = 1;
