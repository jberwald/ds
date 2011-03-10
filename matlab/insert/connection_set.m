function [S failedpaths] = connection_set(map, endpts, opts)
% function [S failedpaths] = connection_set(map, endpts, opts)
% finds all boxes connecting each endpts{i,1} to endpts{i,2}
% opts: 'actionoffset' - use action, and use this offset (path tie-breaking length for action

S = [];
failedpaths = [];

if isfield(opts,'actionoffset')
  if opts.actionoffset < 0
	P = action_scale(map);
  else
	P = action_scale(map,opts.actionoffset);
  end
else
  P = map.P;
end

for i = 1 : size(endpts,1)
  map.tree.count(-1);
  s = map.tree.search(endpts{i,1}, map.tree.depth);
  t = map.tree.search(endpts{i,2}, map.tree.depth);

  path = dijkstra(P, s, t, 0);			% last 0 = no debug
  if (isempty(path))
	failedpaths(i) = 1;
  else
	S = union(S, path);
  end
end

