function showsymregions(map,dat)
% function showsymregions(map,dat)

  figure
  set(gcf,'name','Symbol Regions');

  [sz homology_level] = max(cellfun(@(x) prod(size(x)), dat.SM));
  
  SM_I = graph_mis(dat.SM{homology_level});
  symbol_boxes = cat(2,dat.R{SM_I});

  boxes = map.tree.boxes(-1);
  showraf(boxes',[0.7 1 0]');
  showraf(boxes(:,symbol_boxes)',[0.8 0.7 1]');
  showsymbols(map,dat);