function [map dat] = homoclinic_driver(map,depth,opts)
% function [map dat] = homoclinic_driver(map,depth,opts)
% computes entropy using homoclinic connections:
% 1. uses dijkstra to find the connections at the current depth
% 2. subivides to depth 'depth', keeping only the connections at each stage
% 3. grows an isolated invariont set by adding boxes
% 4. computes the symbolic dynamics for the index poir
%
% opts: struct of options
%   imgname - saves images opts.imgname with suffices
%   per2 - connects to the period 2 orbits
%
% [map dat] = homoclinic_driver(get_map('std',6,'params',2.25),8);
% [map dat] = homoclinic_driver(get_map('std',6,'params',1.5),8);

if nargin < 3
  opts = struct;
end
opts.actionoffset = -1		% use action, default offset

disp('computing homoclinic insertion...')
map = homoclinic_insertion_skinny(map, depth, opts)

disp('growing invariant set...')
map = grow_ip_insert_faster(map,opts);

disp('computing symbolics...')
dat = compute_symbolics(map.I,map,{'noims'});

if isfield(opts,'imgname')
  close
  boxes = map.tree.boxes(-1);
  showraf(boxes(:,dat.X)','c');
  showraf(boxes(:,dat.A)','k');
  set(gca,'xlim',[0 1])
  set(gca,'ylim',[0 1])
  saveas(gcf,[opts.imgname '-ip'],'png')
  
  close
  boxes = shift_boxes(boxes, 0.5, 1);
  boxes = shift_boxes(boxes, -0.5);
  showraf(boxes(:,dat.X)','c');
  showraf(boxes(:,dat.A)','k');
  set(gca,'xlim',[-0.5 0.5])
  set(gca,'ylim',[-0.5 0.5])
  saveas(gcf,[opts.imgname '-ip-slid'],'png')
end
