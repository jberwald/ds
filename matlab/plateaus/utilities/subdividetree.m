function tree = subdividetree(tree,x,y)
  n = tree.count(-1);
  boxes = tree.boxes(-1);
  minrx = min(boxes(3,:))
  minry = min(boxes(4,:))
  
  center = [mean(x);mean(y)];
  radius = [max(x);max(y)] - center - [minrx;minry]/4;
  plotb(tree);
  show2([center;radius]','b');
  S = tree.search_box(center,radius);
  size(S)
  f = flags(S,n);
  tree.unset_flags('all',8,-1);
  tree.set_flags(sprintf('%i',f),8,-1);
  tree.subdivide(8);
  tree.count(-1)
