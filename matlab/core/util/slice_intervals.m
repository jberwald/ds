function Vs = slice_intervals(V,k)
% function Vs = slice_intervals(V,k)
%
%   V - d by L interval matrix, where d is the dimension and L is the number
%   of vectors
%
% slices each vector (column) of V into k equal pieces
  
  
  Vs = intval(zeros(size(V,1),size(V,2)*(k^2)));
  A = repmat(inf(V),1,k^2);
  B = repmat(sup(V),1,k^2);
  D = (B-A)/k;
  whos
  M = repmat(reshape(fill_box(repmat(k,size(V,2),1))',1,size(V,2)*k^2),size(V,1),1);
  Vs = infsup(A+M.*D,A+(M+1).*D);
