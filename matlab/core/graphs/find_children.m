function seen=find_children(A,S)
% input: graph (sparse matrix) A and vertices S
% ouput: all vertices reachable from S in A

n = size(A,1);
A(n+1,n+1) = 0;
A(S,n+1) = 1;
[d dt ft pred] = dfs(A',n+1); % dfs assumes A_ij = edge from i to j
seen = (d>0);
