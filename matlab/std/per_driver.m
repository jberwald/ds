function [map dat] = per_driver(map,maxper,depth,opts)
% function [map dat] = per_driver(map,maxper,depth,opts)
% computes entropy using homoclinic + per 2,3 connections:
% 1. uses dijkstra to find the connections at the current depth
% 2. subivides to depth 'depth', keeping only the connections at each stage
% 3. grows an isolated invariont set by adding boxes
% 4. computes the symbolic dynamics for the index poir
%
% opts: struct of options
%   imgname - saves images opts.imgname with suffices
%
% [map dat] = per_driver(get_map('std',6,'params',2),3,10);
% [map dat] = per_driver(get_map('std',6,'params',1.5),2,8);

if nargin < 3
  opts = struct;
end
if isintval(map.params)
  epsilon = (inf(map.params) + sup(map.params)) / 2;
else
  epsilon = map.params;
end
opts.actionoffset = -1		% use action, default offset

disp('getting orbits...')
BB = good_orbits(map,maxper,depth);

disp('computing homoclinic insertion...')

C = homoclinic_points(epsilon,depth,opts)

cands = cellfun(@(x) x(1:2,1), BB(:,1),'uniformoutput',0);
for i = 1:length(cands)
  for j = i:length(cands)
    if i==j, continue, end
    C(end+1,:) = {cands{i} cands{j}};
  end
end

map = get_map(map.name,map.depth,'params',map.params); % tree is probably
                                                       % screwed up
map = insert_connections(map, C, depth, opts);
save_map_special(map,'per_driver_conns');

disp('growing invariant set...')
map = grow_ip_insert_faster(map,opts);
save_map_special(map,'per_driver_grown');

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
