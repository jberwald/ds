function N = onebox(S,Adj)
% function N = onebox(S,Adj)
% output: the one-box neighborhood N of S, given the adjacency matrix Adj
  N = find(sum(Adj(S,:),1));	% elements adjacent to an element of S
end
