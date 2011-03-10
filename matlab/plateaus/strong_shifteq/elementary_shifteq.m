function [R S] = elementary_shifteq(A,i,j)
% find shift equivalence between A and B, where B is obtained by contracting
% vertices i and j to i in A (and the forward_rule holds)

  n = size(A,1);

  X = [eye(j-1) zeros(j-1,n-j); zeros(1,n-1); zeros(n-j,j-1) eye(n-j)];

  Y = [eye(j-1) zeros(j-1,n-j+1); zeros(n-j,j) eye(n-j)];
  Y(i,j) = 1;							% missed one

  R = A * X;
  S = Y;

end
