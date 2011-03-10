function v = getboxflags(tree)
  boxes = tree.boxes(-1);
  v = floor(boxes(5,:) ./ 2);
