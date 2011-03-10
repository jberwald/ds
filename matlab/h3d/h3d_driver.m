function [map data] = h3d_driver(map,depth,opts)

if nargin < 3
  opts = struct;
end

% connection points:
C = {
%	map.p1 map.h1; map.h1 map.p0;
	  map.p1 map.p0
	};

disp('computing homoclinic insertion...')
map = insert_connections(map, C, depth, opts)

disp('growing invariont set faster...')
map = grow_ip_insert_faster(map,opts);

disp('computing symbolics...')
data = compute_symbolics(map.I,map,{'noims'});
