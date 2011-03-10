function showip(map,dat)
  boxes = map.tree.boxes(-1);
  boxes = shift_boxes(boxes,0.5,1);
  boxes = shift_boxes(boxes, -0.5);
  showraf(boxes','g');
  showraf(boxes(:,dat.X)','c');
  showraf(boxes(:,dat.A)','k');
  set(gca,'xlim',[-0.5 0.5])
  set(gca,'ylim',[-0.5 0.5])
