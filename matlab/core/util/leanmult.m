function B = leanmult(A,p)
% function A = leanmult(A,p)
% input: sparse matrix A, integer p > 0
% output: A^p, or more accurately sponess(spones(A)^p).
%
% total memory used is roughly twice the memory needed to store A. 

% REALLY SLOW !!!

if p==0
  B = speye(size(A));
end

B = A;
for i=2:p
  NNZ = nnz(B);
  r = NNZ*1.0/prod(size(B));
  %  fprintf('i = %i, r = %.2f, nnz = %i\n',i,r,NNZ)
  if NNZ > 50000000 && issparse(B)
	B = full(B);
    %	A = full(A);
  end
  B = ((B*A)~=0);
end
