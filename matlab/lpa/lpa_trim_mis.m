
%clear all
tree = Tree('data/archive/lpa24.tree')
load data/archive/lpa24.mat
S = find(diag(A))
I = grow_isolated(S, A, tree, 24);
n = size(tree.boxes(-1),2)
notI = setdiff(1:n,I);
Attractor = notI(graph_mis(A(notI,notI)));
remove(tree,Attractor);

