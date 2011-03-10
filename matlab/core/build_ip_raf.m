function [X, A] = build_ip_raf(I, P, Adj)

% Building modified combinatorial index pairs for the combinatorial isolating neighborhood I.

n = size(P,1);
oI = onebox(I,Adj);
%%%oI = setdiff(onebox(I,Adj),I); %%% this could be dangerous

% initial X
FI = find(P*flags(I,n));
X = union(I, FI);

% initial A (restricted to neighborhood of I)
A = setdiff(X, I);
A = intersect(A, oI);

new = [1];

while (~isempty(new))
% image of A (restricted to neighborhood of I)
FA = find(P*flags(A,n));
FA = intersect(FA, oI);

% new boxes in oI to be added to A
new = setdiff(FA, A);
% new A
A = union(A, new);
end

% new X
X = union(I, A);

