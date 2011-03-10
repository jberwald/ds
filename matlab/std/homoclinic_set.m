function [TOTAL C intersections] = homoclinic_set(map, intersections)

depth = map.tree.depth;
epsilon = map.params;

q = 2^(-(depth+2)/2);

if nargin < 2 || isempty(intersections)
  disp('Computing intersection of stable and unstable manifolds...');

  [x1 y1 x2 y2 x_points y_points x_reverse y_reverse x_pointss y_pointss x_reverses ...
   y_reverses] = draw_invariant_manifolds(epsilon);

  intersections = [0.5 y1; .5 1-y1; x2 y2; (1-x2) (1-y2)]';  % '
end

disp('Connecting shit up...');

q = 2^(-(depth+2)/2);

map.tree.count(-1);
homoclinic = map.tree.search(intersections)
fixedpoint = [];
fixedpoint(1) = map.tree.search([q;q], depth);
fixedpoint(2) = map.tree.search([1-q;q],depth);
fixedpoint(3) = map.tree.search([q;1-q],depth);
fixedpoint(4) = map.tree.search([1-q;1-q],depth)

if any(fixedpoint < 0)
  TOTAL = [];
  C = {};
  return
end

C = {};

% x1,y1 connection
C{1,1} = dijkstra(map.P,fixedpoint(1),homoclinic(1));
C{1,2} = dijkstra(map.P',fixedpoint(2),homoclinic(1));
C{2,1} = dijkstra(map.P,homoclinic(2),fixedpoint(3));
C{2,2} = dijkstra(map.P',homoclinic(2),fixedpoint(4));

%x2,y2 connection
C{3,1} = dijkstra(map.P,fixedpoint(1),homoclinic(3));
C{3,2} = dijkstra(map.P',fixedpoint(2),homoclinic(3));
C{4,1} = dijkstra(map.P,homoclinic(4),fixedpoint(3));
C{4,2} = dijkstra(map.P',homoclinic(4),fixedpoint(4));

TOTAL = [];
for i = 1 : length(C)
  TOTAL = union(TOTAL, C{i});
end

disp(sprintf('Symbolic length of homoclinic orbit <= %i',length(TOTAL)/4))
