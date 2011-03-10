function Adj=gen_grid_adj(n)
% generates the adjacency matrix for an n by n grid of boxes
% useful for debugging

m = n+2;
A = reshape(1:m^2,m,m)';
D = sparse(m^2,m^2);

keep = reshape(A(2:m-1,2:m-1),1,n^2);

for i=keep
  D(i,[i-m i-m+1 i+1 i+m+1 i+m i+m-1 i-1 i-m-1]) = 1;
end

Adj = D(keep,keep);
