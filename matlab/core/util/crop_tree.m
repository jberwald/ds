function tree = crop_tree(tree,S)
% function crop_tree(tree,S)
% removes all boxes except S from tree
% if no S is given, wipes the tree clean

  tree.unset_flags('all',1);
  n = tree.count(-1);
  keep = repmat('0',[1 n]);

  if nargin > 1
	keep(S) = '1';
  end

  tree.set_flags(keep,1);
  tree.remove(1);

  
