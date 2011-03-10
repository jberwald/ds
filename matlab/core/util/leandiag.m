function v = leandiag(A,B)
% function v = leandiag(A,B)
% finds the nonzero structure of the diagonal of A*B
% that is, computes v such that v = (diag(A*B) ~= 0)

v = any(A' .* B, 1);
  
