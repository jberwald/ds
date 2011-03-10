
function rough_standard_map(map)
%
% function rough_standard_map(mapname)

tic

disp(['Calculating the point of intersection of the manifolds and drawing a' ...
	  ' pretty picture']);
[centerx centery x_points y_points x_reverse y_reverse] = ...
	draw_stable_manifold(1.2,1000000,.00000001,20);

intersections = [0.5 centery; .5 1-centery]';

map.tree.count(-1);
boxes = map.tree.boxes(-1);

homoclinic = map.tree.search(intersections);
disp('Done.');

fixed_connection1 = dijkstra_raf(map.P,homoclinic(1),1);     
fixed_connection2 = dijkstra_raf(map.P,1,homoclinic(2));
fixed_connection3 = dijkstra_raf(map.P,homoclinic(2),1);
fixed_connection4 = dijkstra_raf(map.P,1,homoclinic(1));

TOTAL = union(fixed_connection1, fixed_connection2);
TOTAL = union(TOTAL, fixed_connection3);
TOTAL = union(TOTAL, fixed_connection4);

disp(sprintf('The symbolic length of the homoclinic orbit is at most %i', ...
			 length(TOTAL)))

show2(boxes(:,TOTAL)', 'b');

%disp('Growing isolating neighborhood...');
%I = grow_iso_raf(TOTAL, map.P, map.Adj);
%disp('Growing index pair...');
%[X, A] = build_ip_raf(I, map.P, map.Adj);
%disp('Done.');


%show2(b(:,X)', 'y');                                             
%show2(b(:,A)', 'r');
%axis([0 1 0 1])

% M = index_map(X,A,I,b,mapname,map.P);

toc
